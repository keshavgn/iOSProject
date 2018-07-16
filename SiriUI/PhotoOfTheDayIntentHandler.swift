//
//  PhotoOfTheDayIntentHandler.swift
//  SiriUI
//
//  Created by Keshav on 16/07/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Foundation

class PhotoOfTheDayIntentHandler: NSObject, PhotoOfTheDayIntentHandling {
    
    func confirm(intent: PhotoOfTheDayIntent, completion: @escaping (PhotoOfTheDayIntentResponse) -> Void) {
        let photoViewModel = PhotoViewModel()
        photoViewModel.fetchPhotoOfTheDay { (photoInfo) in
            if let photoInfo = photoInfo {
                if photoInfo.isImage {
                    completion(PhotoOfTheDayIntentResponse(code: .ready, userActivity: nil))
                } else {
                    completion(PhotoOfTheDayIntentResponse(code: .failureNoImage, userActivity: nil))
                }
            }
        }
        
    }
    
    func handle(intent: PhotoOfTheDayIntent, completion: @escaping (PhotoOfTheDayIntentResponse) -> Void) {
        let photoViewModel = PhotoViewModel()
        photoViewModel.fetchPhotoOfTheDay { (photoInfo) in
            if let photoInfo = photoInfo {
                completion(PhotoOfTheDayIntentResponse.success(photoTitle: photoInfo.title))
            }
        }
    }
}

