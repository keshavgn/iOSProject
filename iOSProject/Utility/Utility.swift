//
//  Utility.swift
//  iOSProject
//
//  Created by Keshav on 21/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//
//
import Foundation
import UIKit

public struct Utility {

    static func getObjectTypeName(_ object: Any) -> String {
        let name = String(describing: type(of: object))
        let components = name.components(separatedBy: ".")
        if components.count > 0 {
            return components.last!
        }
        return name
    }

    static func loadLocalData(_ path: String, forClass: AnyClass? = nil) -> Dictionary<String, AnyObject>? {
        var bundle = Bundle.main
        if let anyClass = forClass {
            bundle = Bundle(for: anyClass)
        }
        guard let path = bundle.path(forResource: path, ofType: "json") else {
            return nil
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        do {
            if let jsonData = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? Dictionary<String, AnyObject> {
               return jsonData
            } else {
                debugPrint("Can't load local data from path: \(path)")
                return nil
            }
        } catch {
            debugPrint("Can't load local data from path: \(path)")
            return nil
        }
    }
}

extension Comparable {
    public func isBetween(_ minValue: Self, maxValue: Self) -> Bool {
        return self >= minValue && self <= maxValue
    }
}

// MARK: Equality
public func += <K, V>(left: inout Dictionary<K, V>, right: Dictionary<K, V>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

public struct SystemConstant {
    
    public static let screenBounds = UIScreen.main.bounds
    public static let screenHeight = SystemConstant.screenBounds.size.height
    public static let screenWidth = SystemConstant.screenBounds.size.width
    
    public static var deviceResolution: DeviceResolution {
        let width = min(SystemConstant.screenHeight, SystemConstant.screenWidth)
        if width <= 320.0 {
            // 5, 5s, 5c, SE
            return .dimension1x
        } else if width >= 375.0 && width < 414.0 {
            // 6, 6s, 7, X
            return .dimension2x
        } else if width >= 414.0 && width < 768.0 {
            // plus
            return .dimension3x
        } else {
            // iPad
            return .dimension4x
        }
    }
    
    public static var device: Device {
        let bound = SystemConstant.screenBounds
        let height = max(SystemConstant.screenHeight, SystemConstant.screenWidth)
        switch deviceResolution {
        case .dimension1x, .dimension2x, .dimension3x:
            return height == 812 ? .iPhoneX : .iPhone
        case .dimension4x:
            return bound.width >= 1024 && bound.height >= 1024 ? .iPadPro : .iPad
        }
    }
    
    public static var deviceOrientation: DeviceOrientation {
        return UIDevice.current.orientation.isLandscape ? .landscape : .portrait
    }
    
    public static var appVersion: String {
        return getInfoFromBundle(key: "CFBundleShortVersionString")
    }
    
    public static var buildNumber: String {
        return getInfoFromBundle(key: "CFBundleVersion")
    }
    
    private static func getInfoFromBundle(key: String) -> String {
        if let info = Bundle.main.infoDictionary, let version = info[key] as? String {
            return version
        }
        return ""
    }
    
    public static var isCameraAvailable: Bool {
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
}

public enum DeviceOrientation {
    case portrait, landscape
}

public enum Device {
    case iPhone, iPad, iPadPro, iPhoneX
}

public enum DeviceResolution {
    case dimension1x, dimension2x, dimension3x, dimension4x
}

public enum InterfaceOrientation {
    case portrait, landscape
}

