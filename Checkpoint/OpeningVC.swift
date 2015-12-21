//
//  ViewController.swift
//  Checkpoint
//
//  Created by Linus Liang on 12/14/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import UIKit
import CoreLocation
import AssetsLibrary
import Photos

class OpeningVC: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CheckpointFieldsViewDelegate {

    @IBOutlet weak var checkpointButton: UIButton! {
        didSet {
            checkpointButton.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
        }
    }
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        return imagePicker
    }()
    
    var locationManager: CLLocationManager!
    var location: CLLocation?
    var blurEffectView: UIVisualEffectView?
    var checkpointFieldsView: CheckpointFieldsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view = NSBundle.mainBundle().loadNibNamed("OpeningView", owner: self, options: nil).first as! UIView
        locationManager = CLLocationManager()
        locationManager.delegate = self
        imagePicker.delegate = self
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
            return
        }
        print("lat = \(self.location!.coordinate.latitude), long = \(self.location!.coordinate.longitude)")
        
        self.checkpointFieldsView = createCheckpointFieldsView()
        self.blurEffectView = createBlurEffectView()
        
        fetchAddressWithCoordinates(location!.coordinate) {
            (address: String?) in
            if address != nil {
                print(address!)
                self.checkpointFieldsView!.addressLabel!.text = address!
            }else {
                print("address was nil")
                return
            }
        }
        
        self.view.addSubview(blurEffectView!)
        self.view.addSubview(checkpointFieldsView!)
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 5.0, initialSpringVelocity: 9.0, options: .CurveEaseOut , animations: {
            self.blurEffectView!.alpha = 1.0
            self.checkpointFieldsView!.center = self.view.center
            }, completion: {
                success in
        })
    }
   // MARK: - Helper methods
    
    func createBlurEffectView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        blurEffectView.alpha = 0
        return blurEffectView
    }
    
    func createCheckpointFieldsView() -> CheckpointFieldsView {
        let checkpointFieldsView = NSBundle.mainBundle().loadNibNamed("CheckpointFieldsView", owner: self, options: nil).last as! CheckpointFieldsView
        checkpointFieldsView.frame = CGRect(x: 20, y: -SCREENHEIGHT, width: SCREENWIDTH-40, height: SCREENHEIGHT/3)
        checkpointFieldsView.delegate = self
        return checkpointFieldsView
    }
    
    func openCamera() {
        self.presentViewController(imagePicker, animated: true, completion: nil)
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
        let location:CLLocation? = locations.last as CLLocation?
        self.location = location
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.location = nil
        print("Can't get your location")
    }
    
    // MARK: - ImagePickerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("did finish picking media with info")
        print("saving to photo library")
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromImage(image)
            }, completionHandler: {
                (success:Bool, error: NSError?) in
                print("success = \(success)")
            })
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("canceled taking pic")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - CheckpointFieldsViewDelegate
    func checkpointSaved(success: Bool) {
        if (success) {
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.blurEffectView!.alpha = 0
                self.checkpointFieldsView!.transform = CGAffineTransformMakeScale(0.01, 0.01)
                }, completion: {
                    completionHandler in
                    self.blurEffectView!.removeFromSuperview()
                    self.checkpointFieldsView!.removeFromSuperview()
            })
        } else {
            print("shit failed")
        }
    }
}

