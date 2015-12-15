//
//  ViewController.swift
//  Checkpoint
//
//  Created by Linus Liang on 12/14/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import UIKit
import CoreLocation

class OpeningVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var checkpointButton: UIButton! {
        didSet {
            checkpointButton.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
        }
        
    }
    var locationManager: CLLocationManager!
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view = NSBundle.mainBundle().loadNibNamed("OpeningView", owner: self, options: nil).first as! UIView
        locationManager = CLLocationManager()
        locationManager.delegate = self
        let authorizedStatuses:[CLAuthorizationStatus] = [.AuthorizedAlways, .AuthorizedWhenInUse]
        if !authorizedStatuses.contains(CLLocationManager.authorizationStatus()) {
            print("couldn't get authorization")
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buttonTapped(sender: UIButton) {
        guard (self.location != nil) else {
            print("location was not set")
            let alertVC = UIAlertController(title: "Uh oh, we can't get your location..." , message: "we won't be able to save a checkpoint without your location, but you can change it in your phone settings!", preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertVC, animated: true, completion: nil)
            locationManager.requestWhenInUseAuthorization()
            return
        }
        print("lat = \(self.location!.coordinate.latitude), long = \(self.location!.coordinate.longitude)")
        fetchAddressWithCoordinates(location!.coordinate) {
            (address: String?) in
            if address != nil {
                print(address!)
            }else {
                print("address was nil")
                return
            }
        }
    }
    
    // MARK: - CoreLocation
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("location manager status = \(status)")
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
   // MARK: - CoreLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[locations.count-1] as CLLocation
        self.location = location
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.location = nil
        print("Can't get your location")
    }
}

