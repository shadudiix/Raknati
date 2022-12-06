//
//  HomeViewController.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//
import MapKit
import Polyline

import UIKit
import GoogleMaps

final class HomeViewController: RaknatiBaseViewController, GMSMapViewDelegate, HomeViewDelegates {
    
    // MARK: - Properties
    
    var presenter: HomeVCPresenter!
    
    var googlePolyLine: GMSPolyline?
    
    var cameraLocation: CLLocationCoordinate2D? {
        return self.mapView.camera.target
    }

    // MARK: - UI Components

    private lazy var mapView: GMSMapView = {
        let baseMapView = GMSMapView()
        baseMapView.delegate = self
        baseMapView.camera = GMSCameraPosition(
            latitude: 0.00,
            longitude: 0.00,
            zoom: 16.00
        )
        baseMapView.setMinZoom(4.00, maxZoom: 16.00)
        baseMapView.isMyLocationEnabled = true
        return baseMapView
    }()
    
    private lazy var myLocationButton: RaknatiBaseUIButton = {
        let baseButton = RaknatiBaseUIButton()
        baseButton.setImage(UIImage.createBaseImage(.myLocation, .black), for: .normal)
        return baseButton
    }()
    
    private lazy var settingsButton: RaknatiBaseUIButton = {
        let baseButton = RaknatiBaseUIButton()
        baseButton.setImage(UIImage.createBaseImage(.settings, .black), for: .normal)
        return baseButton
    }()
    
    private lazy var trackingButton: RaknatiBaseUIButton = {
        let baseButton = RaknatiBaseUIButton()
        baseButton.setTitle("Place point", for: .normal)
        return baseButton
    }()
    
    private func layoutView() {
        setupMyLocationButton()
        setupSettingsButton()
    }

    private func setupMyLocationButton() {
        
        self.view.addSubview(myLocationButton)
        let myLocationButtonConstraints = [
            myLocationButton.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 10),
            myLocationButton.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: -10),
        ]
        NSLayoutConstraint.activate(myLocationButtonConstraints)
        
    }
    
    private func setupSettingsButton() {
        
        self.view.addSubview(settingsButton)
        let settingsButtonConstraints = [
            settingsButton.topAnchor.constraint(equalTo: self.myLocationButton.bottomAnchor, constant: 10),
            settingsButton.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: -10),
        ]
        NSLayoutConstraint.activate(settingsButtonConstraints)
        
    }
    
    private func setupButtonsTargets() {
        if(self.myLocationButton.allTargets.isEmpty) {
            self.myLocationButton.addTarget(presenter, action: #selector(presenter.myLocationButtonClicked(_:)), for: .touchUpInside)
        }
        if(self.settingsButton.allTargets.isEmpty) {
            self.settingsButton.addTarget(presenter, action: #selector(presenter.settingsButtonClicked(_:)), for: .touchUpInside)
        }
        if(self.trackingButton.allTargets.isEmpty) {
            self.trackingButton.addTarget(presenter, action: #selector(presenter.trackingButtonClicked(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Life Cycle

    override func loadView() {
        self.view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutView()
        self.showLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupButtonsTargets()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }

    
    // MARK: - Map View Delegates
    
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        self.presenter.isViewInitializated()
    }

    // MARK: - Delegates
    
    func setCameraLocation(_ newLocation: CLLocationCoordinate2D!) {
        mapView.animate(toLocation: newLocation)
    }
    
    func setupTrackButton() {
        
        self.view.addSubview(trackingButton)
        let trackingButtonConstraints = [
            trackingButton.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor, constant: -10),
            trackingButton.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor, constant: 10),
            trackingButton.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(trackingButtonConstraints)
        
    }
    
    func setTrackingButtonTitle(_ buttonTitle: String!) {
        self.googlePolyLine?.map = nil
        self.googlePolyLine = nil
        self.trackingButton.setTitle(buttonTitle, for: .normal)
    }
    
    func setVechileMarker(_ vechileLocation: CLLocationCoordinate2D!) {
        let vechileMarker = GMSMarker.init(position: vechileLocation)
        vechileMarker.iconView = UIImageView(image: UIImage.createBaseImage(.vechile, .systemBlue))
        vechileMarker.appearAnimation = .fadeIn
        vechileMarker.map = mapView
        let gmsCircle = GMSCircle(position: vechileLocation, radius: 50)
        gmsCircle.fillColor = .systemBlue.withAlphaComponent(0.25)
        gmsCircle.strokeColor = .systemBlue
        gmsCircle.strokeWidth = 2.5
        gmsCircle.map = mapView
    }
    
    func clearMap() {
        self.mapView.clear()
        self.googlePolyLine?.map = nil
        self.googlePolyLine = nil
    }
    
    func drawRoute(
        _ sourceLocation: CLLocationCoordinate2D!,
        _ destinationLocation: CLLocationCoordinate2D!) {
            
        let sourceCoordinate = MKMapItem(placemark: .init(coordinate: sourceLocation))
        let destinationCoordinate = MKMapItem(placemark: .init(coordinate: destinationLocation))
        let mapKitDirectionRequest = MKDirections.Request()
        mapKitDirectionRequest.source = sourceCoordinate
        mapKitDirectionRequest.destination = destinationCoordinate
        mapKitDirectionRequest.transportType = .walking
        mapKitDirectionRequest.requestsAlternateRoutes = false
        let MKdirections = MKDirections(request: mapKitDirectionRequest)
        MKdirections.calculate { calculateResult, calculateError in
            guard let calculateResult = calculateResult, calculateError == nil,
                  let suggestedRoute = calculateResult.routes.first, self.presenter.currentTrackingStatus == .started else {
                return
            }
            var coreLocationCoordinate = [CLLocationCoordinate2D](
                repeating: kCLLocationCoordinate2DInvalid,
                count: suggestedRoute.polyline.pointCount)
            suggestedRoute.polyline.getCoordinates(
                &coreLocationCoordinate,
                range: NSRange(location: 0, length: suggestedRoute.polyline.pointCount))
            let thirdPartyPolyine = Polyline.init(coordinates: coreLocationCoordinate)
            let googleMapPath = GMSPath.init(fromEncodedPath: thirdPartyPolyine.encodedPolyline)
            if(self.googlePolyLine != nil) {
                self.googlePolyLine?.map = nil
                self.googlePolyLine = nil
            }
            self.googlePolyLine = GMSPolyline.init(path: googleMapPath)
            self.googlePolyLine?.strokeWidth = 7.5
            self.googlePolyLine?.spans = [.init(style: .solidColor(.systemBlue))]
            self.googlePolyLine?.map = self.mapView
        }
    }
    
}

