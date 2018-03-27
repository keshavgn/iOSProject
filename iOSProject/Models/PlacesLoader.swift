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
    print("Load pois")
    let latitude = location.coordinate.latitude
    let longitude = location.coordinate.longitude
    
    let uri = apiURL + "nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&types=establishment&key=\(apiKey)&sensor=true"
    
    let url = URL(string: uri)!
    var urlRequest = URLRequest(url: url)
    urlRequest.setValue("133.237.7.84", forHTTPHeaderField: "Referer")
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let dataTask = session.dataTask(with: urlRequest) { data, response, error in
      if let error = error {
        print(error)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          print(data!)
          
          do {
            let responseObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            guard let responseDict = responseObject as? NSDictionary else {
              return
            }
            
            handler(responseDict, nil)
      
          } catch let error as NSError {
            handler(nil, error)
          }
        }
      }
    }
    
    dataTask.resume()
  }
  
  func loadDetailInformation(forPlace: Place, handler: @escaping (NSDictionary?, NSError?) -> Void) {
    
    let uri = apiURL + "details/json?reference=\(forPlace.reference)&sensor=true&key=\(apiKey)"
    
    let url = URL(string: uri)!
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let dataTask = session.dataTask(with: url) { data, response, error in
      if let error = error {
        print(error)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          print(data!)
          
          do {
            let responseObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            guard let responseDict = responseObject as? NSDictionary else {
              return
            }
            
            handler(responseDict, nil)
            
          } catch let error as NSError {
            handler(nil, error)
          }
        }
      }
    }
    
    dataTask.resume()

  }
}
