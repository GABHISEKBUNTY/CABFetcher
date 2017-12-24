//
//  UBERCabModel.swift
//  CabFetcher
//
//  Created by Abhisek on 23/12/17.
//  Copyright © 2017 Abhisek. All rights reserved.
//

import Foundation

public class UBERCab: NSObject {
    
    public var localized_display_name: String? = nil
    public var distance: Double? = nil
    public var display_name: String? = nil
    public var product_id: String? = nil
    public var high_estimate: Double? = nil
    public var low_estimate: Double? = nil
    public var duration: Int64? = nil
    public var priceEstimate: String? = nil
    public var currency_code:String? = nil
    public var estimate:String? = nil
    
    init(attributes: [String:Any]) {
        
        if let localized_display_name = attributes["localized_display_name"] as? String {
            self.localized_display_name = localized_display_name
        }
        
        if let distance = attributes["distance"] as? Double {
            self.distance = distance
        }
        
        if let display_name = attributes["display_name"] as? String {
            self.display_name = display_name
        }
        
        if let high_estimate = attributes["high_estimate"] as? Double {
            self.high_estimate = high_estimate
        }
        
        if let low_estimate = attributes["low_estimate"] as? Double {
            self.low_estimate = low_estimate
        }
        
        if let duration = attributes["duration"] as? Int64 {
            self.duration = duration
        }
        
        
        if let currency_code = attributes["currency_code"] as? String {
            self.currency_code = currency_code
        }
        
        if let product_id = attributes["product_id"] as? String {
            self.product_id = product_id
        }
        
        if let estimate = attributes["estimate"] as? String {
            self.estimate = estimate
        }
        
    }
}
