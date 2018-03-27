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

    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate var startedLoadingPOIs = false
    fileprivate var places = [Place]()
    fileprivate var arViewController: ARViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if (authorizationStatus == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        locationManager.requestAlwaysAuthorization()
    }

    @IBAction func cameraAction(_ sender: Any) {
        arViewController = ARViewController()
        arViewController.dataSource = self
        arViewController.presenter.maxVisibleAnnotations = 30
        arViewController.trackingManager.headingFilterFactor = 0.05
        arViewController.setAnnotations(places)
        self.present(arViewController, animated: true, completion: nil)
    }
    
    
}

extension AugmentedRealityViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            let location = locations.last!
            print("Accuracy: \(location.horizontalAccuracy)")
            
            if location.horizontalAccuracy < 100 {
                manager.stopUpdatingLocation()
                let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.region = region
                
                if !startedLoadingPOIs {
                    startedLoadingPOIs = true
                    let loader = PlacesLoader()
                    loader.loadPOIS(location: location, radius: 1000) { placesDict, error in
                        if let dict = placesDict {
                            guard let placesArray = dict.object(forKey: "results") as? [NSDictionary]  else { return }
                            for placeDict in placesArray {
                                let latitude = placeDict.value(forKeyPath: "geometry.location.lat") as! CLLocationDegrees
                                let longitude = placeDict.value(forKeyPath: "geometry.location.lng") as! CLLocationDegrees
                                let reference = placeDict.object(forKey: "reference") as! String
                                let name = placeDict.object(forKey: "name") as! String
                                let address = placeDict.object(forKey: "vicinity") as! String
                                
                                let location = CLLocation(latitude: latitude, longitude: longitude)
                                let place = Place(location: location, reference: reference, name: name, address: address)
                                self.places.append(place)
                                let annotation = PlaceAnnotation(location: place.location.coordinate, title: place.place)
                                DispatchQueue.main.async {
                                    self.mapView.addAnnotation(annotation)
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
        annotationView.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        
        return annotationView
    }
}

extension AugmentedRealityViewController: AnnotationViewDelegate {
    func didTouch(annotationView: AnnotationView) {
        if let annotation = annotationView.annotation as? Place {
            let placesLoader = PlacesLoader()
            placesLoader.loadDetailInformation(forPlace: annotation) { resultDict, error in
                
                if let infoDict = resultDict?.object(forKey: "result") as? NSDictionary {
                    annotation.phoneNumber = infoDict.object(forKey: "formatted_phone_number") as? String
                    annotation.website = infoDict.object(forKey: "website") as? String
                    
                    self.showInfoView(forPlace: annotation)
                }
            }
        }
    }
    
    func showInfoView(forPlace place: Place) {
        let alert = UIAlertController(title: place.place , message: place.infoText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        arViewController.present(alert, animated: true, completion: nil)
    }
}

