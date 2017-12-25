//
//  OLAManager.swift
//  CabFetcherExample
//
//  Created by Abhisek on 24/12/17.
//  Copyright © 2017 Abhisek. All rights reserved.
//

import Foundation
import CoreLocation

enum OLARequestURL {
    
    static let baseUrl = "https://devapi.olacabs.com"
    static let rideEstimateUrl = "/v1/products"
    
}

let olaCabCategories = ["micro","mini","share","prime","suv","prime_play","lux","rental","outstation","sedan"]

public class OLAManager {
    
    static let sharedOLAManager = OLAManager()
    
    var partnerUniqueKey = ""
    var userUniqueKey = ""
    
    public class func initializeOLAManager(partnerUniqueKey: String, userUniqueKey: String? ) {
        OLAManager.sharedOLAManager.partnerUniqueKey = partnerUniqueKey
        if let userUniqueKey = userUniqueKey {
            OLAManager.sharedOLAManager.userUniqueKey = userUniqueKey
        }
    }
    
    public func getOLACabs(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, completion: @escaping (_ cabList: [UBERCab]?, _ errorMessage:String?)->Void) {
        
        
        
        
        
        
    }
    
    fileprivate func requestOLACab(forCategory category: String, startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, completion: @escaping (_ cabList: [String: AnyObject]?, _ errorMessage:String?)->Void) {
        
        
        let startLatitude = String(startLocation.latitude)
        let startLongitude = String(startLocation.longitude)
        
        let endLatitude = String(endLocation.latitude)
        let endLongitude = String(endLocation.longitude)
        
        let urlString = OLARequestURL.baseUrl+OLARequestURL.rideEstimateUrl + "pickup_lat=\(startLatitude)&pickup_lng=\(startLongitude)&drop_lat=\(endLatitude)&drop_lng=\(endLongitude)"
        
        CABFetcherWebService.sharedService.requestAPI(url: urlString, parameter: nil, httpMethodType: .GET) { (data, error) in
            
            if error != nil {
                completion(nil,error?.localizedDescription)
            }
            
            guard let cabEstimate = data?["ride_estimate"] as? [[String:AnyObject]] else {
                completion(nil, "Empty cab list.")
                return
            }
            
            
        }
        
    }
    
}
    

