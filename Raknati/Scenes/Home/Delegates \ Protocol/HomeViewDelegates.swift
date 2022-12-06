//
//  HomeViewDelegates.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 29/11/2022.
//

import Foundation
import CoreLocation

protocol HomeViewDelegates: AnyObject {
    var presenter: HomeVCPresenter! { get set }
    var cameraLocation: CLLocationCoordinate2D? { get }
    func setCameraLocation(_ newLocation: CLLocationCoordinate2D!)
    func setupTrackButton()
    func setTrackingButtonTitle(_ buttonTitle: String!)
    func setVechileMarker(_ vechileLocation: CLLocationCoordinate2D!)
    func clearMap()
    func drawRoute(
        _ sourceLocation: CLLocationCoordinate2D!,
        _ destinationLocation: CLLocationCoordinate2D!)
}

typealias HomeDelegates = HomeViewDelegates & BaseViewControllerDelegates
