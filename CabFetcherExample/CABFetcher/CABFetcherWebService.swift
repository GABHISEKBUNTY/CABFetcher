//
//  CABFetcherWebService.swift
//  PracticeFramework
//
//  Created by Abhisek on 22/12/17.
//  Copyright © 2017 Abhisek. All rights reserved.
//

import Foundation
class CABFetcherWebService {
    
    typealias CABFetcherWebServiceCompletionBlock = (_ data: [String:AnyObject]?,_ error: Error?)->Void
    
    static let sharedService = CABFetcherWebService()
    
    enum HTTPMethodType: Int {
        case POST = 0
        case GET
    }
    
    func requestAPI(url: String,parameter: [String: AnyObject]?, httpMethodType: HTTPMethodType, completion: @escaping CABFetcherWebServiceCompletionBlock) {
        
        var request = URLRequest(url: URL(string: url)!)
        
        switch httpMethodType {
        case .POST:
            request.httpMethod = "POST"
        case .GET:
            request.httpMethod = "GET"
            
            if parameter != nil{
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameter as Any, options: .prettyPrinted)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Token "+UBERManager.sharedUBERManager.token, forHTTPHeaderField: "Authorization")
            request.addValue("en_US", forHTTPHeaderField: "Accept-Language")
            
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data, error == nil else {                                                                 return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("Error in fetching response")
                }
                
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        completion(json as [String : AnyObject],nil)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    completion(nil,error)
                }
                
            }
            task.resume()
            
        }
        
    }
}
