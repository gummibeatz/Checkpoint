//
//  APICalls.swift
//  Checkpoint
//
//  Created by Linus Liang on 12/14/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

func fetchAddressWithCoordinates(coordinates: CLLocationCoordinate2D, completion: (address: String?) -> () ) {
    let url = "https://maps.googleapis.com/maps/api/geocode/json"
    let params = ["latlng":"\(coordinates.latitude),\(coordinates.longitude)"]
    Alamofire.request(.GET, url , parameters: params, encoding: .URL , headers: nil).response {
        request, response, data, error in
        do {
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let address: String? = (dict.objectForKey("results") as? [NSDictionary])?.first?.objectForKey("formatted_address") as? String
            completion(address: address)
        } catch {
            print("error = \(error)")
            completion(address: nil)
        }
    }
}