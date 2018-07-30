//
//  GoogleStreetViewViewController.swift
//  iOSProject
//
//  Created by Keshav on 29/07/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import GoogleMaps

final class GoogleStreetViewViewController: UIViewController {

    @IBOutlet weak var mapView: GMSPanoramaView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationManager()
        setupMapView()
    }
    
    private func setupLocationManager() {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if (authorizationStatus == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.moveNearCoordinate(CLLocationCoordinate2D(latitude: 37.3317134, longitude: -122.0307466))
    }

}

extension GoogleStreetViewViewController: GMSPanoramaViewDelegate {
    func panoramaView(_ view: GMSPanoramaView, error: Error, onMoveNearCoordinate coordinate: CLLocationCoordinate2D) {
        print(error.localizedDescription)
    }
}

extension GoogleStreetViewViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            guard let location = locations.last else { return }
            mapView.moveNearCoordinate(location.coordinate)
        }
    }
}
