//
//  ViewController.swift
//  SampleApp
//
//  Created by Abhisek on 22/12/17.
//  Copyright © 2017 Abhisek. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var uberTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var uberCabList = [UBERCab]()
    var toastLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UBERManager.initializeUBERManager(token: "0dXlmwFLk06mu9YGS05b99f-msjOi092ib5YvHum", client_id: "R3tWd7M64yaOyYMTfJEWA2KZLReDF-mS")
        uberTableView.dataSource = self
        activityIndicator.isHidden = true
    }
    
    @IBAction func getUberList(_ sender: Any) {
        
        let startLocation = CLLocationCoordinate2D(latitude: 20.2863241, longitude: 85.7951519)
        let endLocation = CLLocationCoordinate2D(latitude: 20.3514536, longitude: 85.8066918)
        self.showLoader()
        UBERManager.sharedUBERManager.getUBERCabs(startLocation: startLocation, endLocation: endLocation) { (cabList, errorMessage) in
            
            DispatchQueue.main.async {
                self.hideLoader()
                //Handle error
                if let error = errorMessage{
                   print(error)
                }
                
                //Load cab list
                if let cabs = cabList {
                    self.uberCabList = cabs
                    self.uberTableView.reloadData()
                }
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: Helper Methods
extension ViewController {
    
    func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideLoader() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    
}


//MARK: UITableViewDataSource Methods
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uberCabList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = uberTableView.dequeueReusableCell(withIdentifier: "UberCell", for: indexPath)
        let cab = uberCabList[indexPath.row]
        cell.textLabel?.text = cab.localized_display_name
        cell.detailTextLabel?.text = cab.estimate
        cell.imageView?.image = #imageLiteral(resourceName: "uberCabImage")
        return cell
        
    }
    
}

