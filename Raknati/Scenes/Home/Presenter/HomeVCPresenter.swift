//
//  HomeVCPresenter.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 29/11/2022.
//

import Foundation
import CoreLocation
import UserNotifications

protocol HomePresenterDelgates: AnyObject {
    func stopLocationUpdates()
}

final class HomeVCPresenter: NSObject, HomePresenterDelgates {
    
    // MARK: - Properties Concurrnecy
    
    private let concurrencyThreadSafe = DispatchQueue(label: "...", attributes: .concurrent)
    
    private let trackingQueue = DispatchQueue(label: "..", qos: .userInitiated, attributes: .concurrent)
    
    private let locationTrackingSemaphore = DispatchSemaphore(value: 1)
    
    // MARK: - Properties

    private var viewIsInitializated: Bool = false
    
    private var locationManager: CLLocationManager!
    
    private var homeRepoManager: HomeRepositoryManager!
    
    private weak var view: HomeDelegates?
    
    weak var coordinator: HomeCoordinator?

    private var currentLocation: CLLocationCoordinate2D! {
        guard let currentLocation = self.locationManager.location?.coordinate else {
            return CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)
        }
        return CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
    }
    
    private var documentUUID: String?
    private var realTrackingLocation: GeoLocationEntity?
    private var trackingLocation: GeoLocationEntity? {
        get {
            return concurrencyThreadSafe.sync { [weak self] in
                return self?.realTrackingLocation
            }
        } set {
            concurrencyThreadSafe.sync { [weak self] in
                self?.realTrackingLocation = newValue
            }
        }
    }
    
    enum TrackingStatus: Int {
        case undefined
        case ready
        case started
    }
    
    var currentTrackingStatus: TrackingStatus! = .undefined
    
    // MARK: - Initialization
    
    init(locationManager: CLLocationManager!, homeRepoManager: HomeRepositoryManager, view: HomeDelegates!, coordinator: HomeCoordinator) {
        super.init()
        self.homeRepoManager = homeRepoManager
        self.locationManager = locationManager
        self.view = view
        self.coordinator = coordinator
        self.setupLocationManager()
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Functions
    
    func isViewInitializated() {
        concurrencyThreadSafe.sync {
            if(self.viewIsInitializated == false) {
                self.viewIsInitializated.toggle()
                self.view?.setupTrackButton()
                self.updateCameraLocationToCurrentLocation()
                self.homeRepoManager.retrieveLastGeoPoint { [weak self] retrieveLastGeoPoint in
                    self?.view?.hideLoading()
                    switch(retrieveLastGeoPoint) {
                        case .success(let geoModel, let documentUUID):
                            self?.placePoint(geoModel, documentUUID)
                        case .failure(let fetchErrorCode):
                            guard let fetchErrorCode = fetchErrorCode as? RaknatiErrorCodes, fetchErrorCode == .emptyCollection else {
                                self?.view?.showAlert(fetchErrorCode.localizedDescription)
                                return
                            }
                    }
                }
            }
        }
    }

    func updateCameraLocationToCurrentLocation() {
        self.view?.setCameraLocation(currentLocation)
    }
    
    private func placePoint(_ geoModel: GeoLocationEntity!, _ documentUUID : String!) {
        self.locationTrackingSemaphore.wait()
        self.currentTrackingStatus = .ready
        self.documentUUID = documentUUID
        self.trackingLocation = geoModel
        self.view?.setTrackingButtonTitle("Start Tracking")
        self.view?.setVechileMarker(.init(latitude: geoModel.latitude, longitude: geoModel.longitude))
        self.locationTrackingSemaphore.signal()
    }
    
    private func startTracking() {
        self.locationTrackingSemaphore.wait()
        self.currentTrackingStatus = .started
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
        self.view?.setTrackingButtonTitle("Stop Tracking")
        self.locationTrackingSemaphore.signal()
    }
    
    func stopLocationUpdates() {
        self.locationTrackingSemaphore.wait()
        self.locationManager.stopUpdatingLocation()
        self.documentUUID = nil
        self.trackingLocation = nil
        self.currentTrackingStatus = .undefined
        self.locationTrackingSemaphore.signal()
    }
    
    private func stopTracking() {
        self.view?.showLoading()
        self.homeRepoManager.stopTracking(documentUUID: self.documentUUID) { [weak self] updateResult in
            guard let self = self else { return }
            self.locationTrackingSemaphore.wait()
            switch(updateResult) {
                case .success(_):
                    self.documentUUID = nil
                    self.trackingLocation = nil
                    self.currentTrackingStatus = .undefined
                    self.view?.setTrackingButtonTitle("Place point")
                    self.locationManager.stopUpdatingLocation()
                    self.view?.clearMap()
                case .failure(let updateError):
                    self.view?.showAlert(updateError.localizedDescription)
            }
            self.locationTrackingSemaphore.signal()
            self.view?.hideLoading()
        }
    }
    
}


extension HomeVCPresenter {
    
    // MARK: - Buttons Events
    
    @objc func myLocationButtonClicked(_ sender: Any!) {
        self.updateCameraLocationToCurrentLocation()
    }
    
    @objc func settingsButtonClicked(_ sender: Any!) {
        self.coordinator?.pushAppSettings(delegates: self)
    }
    
    @objc func trackingButtonClicked(_ sender: Any!) {
        if(self.currentTrackingStatus == .undefined) {
            self.view?.showLoading()
            let geoEntity = GeoLocationEntity.init(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
            self.homeRepoManager.saveEntity(geoEntity) { [weak self] saveReult in
                guard let self = self else { return }
                self.view?.hideLoading()
                switch(saveReult) {
                    case .success( let documentUUID):
                    self.placePoint(geoEntity, documentUUID)
                    case .failure(let saveError):
                        self.view?.showAlert(saveError.localizedDescription)
                }
            }

        } else if(self.currentTrackingStatus == .ready) {
            self.startTracking()
        } else if(self.currentTrackingStatus == .started) {
            self.view?.showYesNoQuestion("Are you reached your vechile?", handler: { [weak self] questionResult in
                guard let self = self, questionResult == true else { return }
                self.stopTracking()
            })
        }
    }

}


extension HomeVCPresenter {
    
    // MARK: - Location Manager
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
}


extension HomeVCPresenter: CLLocationManagerDelegate {
    
    // MARK: - Location Manager Delegates
    
//    @available(iOS 14.0, *)
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        self.startLocationManager(manager.authorizationStatus)
//    }
    
//    @available(iOS 13.0, *)
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        self.startLocationManager(status)
//    }
    
    /// We must implement this function, or the app will be crashed.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        trackingQueue.async { [weak self] in
            if(self?.locationTrackingSemaphore.wait(timeout: .now() + 1.5) == .success) {
                guard let self = self,
                      self.currentTrackingStatus == .started,
                      let trackingLocation = self.trackingLocation,
                      let lastLocation = locations.last,
                      let cameraLocation = self.view?.cameraLocation else {
                            self?.locationTrackingSemaphore.signal()
                        return
                }
                let trackingCoordinate = CLLocation.init(latitude: trackingLocation.latitude, longitude: trackingLocation.longitude)
                let cameraCoordinate = CLLocation.init(latitude: cameraLocation.latitude, longitude: cameraLocation.longitude)
                let cameraDistanceInMeters = lastLocation.distance(from: cameraCoordinate)
                DispatchQueue.main.async {
                    if(cameraDistanceInMeters >= 10) {
                        self.updateCameraLocationToCurrentLocation()
                    }
                    self.view?.drawRoute(lastLocation.coordinate, trackingCoordinate.coordinate)
                }
                sleep(2)
                self.locationTrackingSemaphore.signal()
            }
        }
    }

}
