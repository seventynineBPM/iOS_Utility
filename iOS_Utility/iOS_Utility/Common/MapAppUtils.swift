//
//  MapAppUtils.swift
//  iOS_Utility
//
//  Created by Joongsun Joo on 2020/02/13.
//  Copyright © 2020 Joongsun Joo. All rights reserved.
//

import Foundation
import MapKit

class MapAppUtils {
    
    static func openAppleMap(location :CLLocation, placeName: String) {
        let coordinates = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        self.openAppleMap(coordinates: coordinates, placeName: placeName)
    }
    
    static func openAppleMap(latitude :Double, longitude :Double, placeName: String) {
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        self.openAppleMap(coordinates: coordinates, placeName: placeName)
    }
    
    static func openAppleMap(coordinates :CLLocationCoordinate2D, placeName: String) {
        let regionSpan = MKCoordinateRegion.init(center: coordinates, latitudinalMeters: 500, longitudinalMeters: 500)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: options)
    }
    
    static func openGoogleMap(location :CLLocation, placeName: String) -> Bool {
        
        let latitude :Double = Double(location.coordinate.latitude)
        let longitude :Double = Double(location.coordinate.longitude)
        
        return self.openGoogleMap(latitude: latitude, longitude: longitude, placeName: placeName)
    }
    
    static func openGoogleMap(latitude :Double, longitude :Double, placeName: String) -> Bool {
        if !UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            return false
        }
        
        
        let zoom = 15
        let placeName = placeName
        
        var urlString = "comgooglemaps://?q=\(placeName)&center=\(String(describing: latitude)),\(String(describing: longitude))&zoom=\(String(describing: zoom))"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([String : Any]()), completionHandler: {
                if !$0 {
                    
                }
            })
        } else {
            UIUtils.showSimpleAlert(title: "", message: "지도 열기에 실패 하였습니다.")
        }
        
        return true
    }
}

fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
