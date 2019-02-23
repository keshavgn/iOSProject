//
//  AugmentedRealityViewController.swift
//  iOSProject
//
//  Created by Keshav on 26/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import HDAugmentedReality

final class AugmentedRealityViewController: UIViewController {

    private struct Constant {
        static let results = "results"
        static let geometryLocationLat = "geometry.location.lat"
        static let geometryLocationLng = "geometry.location.lng"
        static let reference = "reference"
        static let name = "name"
        static let vicinity = "vicinity"
        static let formattedPhoneNumber = "formatted_phone_number"
        static let result = "result"
        static let website = "website"
        static let horizontalAccuracy: Double = 100
        static let delta: Double =  0.014
        static let radius = 1000
        static let anotationViewFrame = CGRect(x: 0, y: 0, width: 150, height: 50)
        static let maxVisibleAnnotations = 30
        static let headingFilterFactor: Double = 0.05
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cameraBarButtonItem: UIBarButtonItem!
    
    fileprivate var startedLoadingPOIs = false
    fileprivate var places = [Place]()
    fileprivate var arViewController: ARViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        navigationItem.rightBarButtonItem = cameraBarButtonItem
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

    @IBAction func cameraAction(_ sender: Any) {
        arViewController = ARViewController()
        arViewController.dataSource = self
        arViewController.presenter.maxVisibleAnnotations = Constant.maxVisibleAnnotations
        arViewController.trackingManager.headingFilterFactor = Constant.headingFilterFactor
        arViewController.setAnnotations(places)
        self.present(arViewController, animated: true, completion: nil)
    }
}

extension AugmentedRealityViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            guard let location = locations.last else { return }
            
            if location.horizontalAccuracy < Constant.horizontalAccuracy {
                manager.stopUpdatingLocation()
                let span = MKCoordinateSpan(latitudeDelta: Constant.delta, longitudeDelta: Constant.delta)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.region = region
                
                if !startedLoadingPOIs {
                    startedLoadingPOIs = true
                    let loader = PlacesLoader()
                    loader.loadPOIS(location: location, radius: Constant.radius) { [weak self] placesDict, error in
                        if let dict = placesDict {
                            guard let placesArray = dict.object(forKey: Constant.results) as? [NSDictionary]  else { return }
                            for placeDict in placesArray {
                                let latitude = placeDict.value(forKeyPath: Constant.geometryLocationLat) as! CLLocationDegrees
                                let longitude = placeDict.value(forKeyPath: Constant.geometryLocationLng) as! CLLocationDegrees
                                let reference = placeDict.object(forKey: Constant.reference) as! String
                                let name = placeDict.object(forKey: Constant.name) as! String
                                let address = placeDict.object(forKey: Constant.vicinity) as! String
                                
                                let location = CLLocation(latitude: latitude, longitude: longitude)
                                let place = Place(location: location, reference: reference, name: name, address: address)
                                self?.places.append(place)
                                let annotation = PlaceAnnotation(location: place.location.coordinate, title: place.place)
                                DispatchQueue.main.async {
                                    self?.mapView.addAnnotation(annotation)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension AugmentedRealityViewController: ARDataSource {
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        let annotationView = AnnotationView()
        annotationView.annotation = viewForAnnotation
        annotationView.delegate = self
        annotationView.frame = Constant.anotationViewFrame
        return annotationView
    }
}

extension AugmentedRealityViewController: AnnotationViewDelegate {
    func didTouch(annotationView: AnnotationView) {
        if let annotation = annotationView.annotation as? Place {
            let placesLoader = PlacesLoader()
            placesLoader.loadDetailInformation(forPlace: annotation) { [weak self] resultDict, error in
                if let infoDict = resultDict?.object(forKey: Constant.result) as? NSDictionary {
                    annotation.phoneNumber = infoDict.object(forKey: Constant.formattedPhoneNumber) as? String
                    annotation.website = infoDict.object(forKey: Constant.website) as? String
                    self?.showInfoView(forPlace: annotation)
                }
            }
        }
    }
    
    func showInfoView(forPlace place: Place) {
        let alert = UIAlertController(title: place.place , message: place.infoText, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        arViewController.present(alert, animated: true, completion: nil)
    }
}

