//
//  UBERManager.swift
//
//  Created by Abhisek on 21/12/17.
//  Copyright © 2017 Abhisek. All rights reserved.
//

import UIKit
import CoreLocation

enum UBERRequestURL {
    
    static let baseUrl = "https://api.uber.com"
    static let fareEstimete = "/v1.2/estimates/price?"
    static let timeEstimate = "/v1.2/estimates/time"
    
}


public class UBERManager: NSObject {
    
    public static let sharedUBERManager = UBERManager()
    
    var token = ""
    var client_id = ""
    
    public class func initializeUBERManager(token: String,client_id: String? ) {
        UBERManager.sharedUBERManager.token = token
        if let client_id = client_id {
        UBERManager.sharedUBERManager.client_id = client_id
        }
    }
    
    public func openUberApp(selectedProductId: String,startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, completion: (Bool)->()) {
        
        if UIApplication.shared.canOpenURL(URL(string: "uber://")!) {
            // Uber app is installed, construct and open deep link.
            UIApplication.shared.open(URL(string: "uber://?client_id=\(self.client_id)&action=setPickup&pickup[latitude]=\(startLocation.latitude)&pickup[longitude]=\(startLocation.longitude)&dropoff[latitude]=\(endLocation.latitude)&dropoff[longitude]=\(endLocation.longitude)&product_id=\(selectedProductId)")!, options: [:],
                                      completionHandler: {
                                        (success) in
            })
            completion(true)
        } else {
            completion(false)
        }
        
    }
  
    
    public func getUBERCabs(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, completion: @escaping (_ cabList: [UBERCab]?, _ errorMessage:String?)->Void) {
        
        let startLatitude = String(startLocation.latitude)
        let startLongitude = String(startLocation.longitude)

        let endLatitude = String(endLocation.latitude)
        let endLongitude = String(endLocation.longitude)
        
        let urlString = UBERRequestURL.baseUrl+UBERRequestURL.fareEstimete + "start_latitude=\(startLatitude)&start_longitude=\(startLongitude)&end_latitude=\(endLatitude)&end_longitude=\(endLongitude)"
        UBERManagerWebService.sharedService.requestAPI(url: urlString, parameter: nil, httpMethodType: .GET) { (data, error) in
            
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            
            guard let priceList = data?["prices"] as? [[String:AnyObject]] else {
                completion(nil, "Empty cab list.")
                return
            }
            
            var cabList = [UBERCab]()
            for individualCab in priceList {
                cabList.append(UBERCab(attributes: individualCab))
            }
            
            completion(cabList, nil)
        }
    }
    
}


