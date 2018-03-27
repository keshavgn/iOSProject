//
//  PlacesLoader.swift
//  iOSProject
//
//  Created by Keshav on 26/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Foundation
import CoreLocation

struct PlacesLoader {
    let apiURL = "https://maps.googleapis.com/maps/api/place/"
    let apiKey = "AIzaSyDn16NpRX5TcoG9_QD9_KBsykrNKdtIrOA"

    func loadPOIS(location: CLLocation, radius: Int = 30, handler: @escaping (NSDictionary?, NSError?) -> Void) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let urlString = apiURL + "nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&types=establishment&key=\(apiKey)&sensor=true"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    do {
                        let responseObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        guard let responseDict = responseObject as? NSDictionary else { return }
                        handler(responseDict, nil)
                    } catch let error as NSError {
                        handler(nil, error)
                    }
                }
            }
        }.resume()
    }
  
  func loadDetailInformation(forPlace: Place, handler: @escaping (NSDictionary?, NSError?) -> Void) {
    let urlString = apiURL + "details/json?reference=\(forPlace.reference)&sensor=true&key=\(apiKey)"
    guard let url = URL(string: urlString) else { return }
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: url) { data, response, error in
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                do {
                    let responseObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    guard let responseDict = responseObject as? NSDictionary else { return }
                    handler(responseDict, nil)
                } catch let error as NSError {
                    handler(nil, error)
                }
            }
        }
        }.resume()
    }
    
}
