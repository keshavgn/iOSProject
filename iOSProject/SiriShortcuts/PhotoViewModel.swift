//
//  PhotoViewModel.swift
//  iOSProject
//
//  Created by Keshav on 16/07/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Foundation

struct PhotoViewModel {
    
    let baseURL = URL(string: "https://api.nasa.gov")!.appendingPathComponent("planetary").appendingPathComponent("apod")
    let queryParams = ["api_key": "DEMO_KEY"]
    
    func fetchPhotoOfTheDay(completion: @escaping (PhotoInfo?) -> Void) {
        let url = baseURL.withQuery(queryParams)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func fetchUrlData(with url: URL, completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(data)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
}

extension URL {
    
    func withQuery(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap({ URLQueryItem(name: $0.0, value: $0.1) })
        return components?.url
    }
    
}
