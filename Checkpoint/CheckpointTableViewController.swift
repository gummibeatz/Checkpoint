//
//  CheckpointTableViewController.swift
//  Checkpoint
//
//  Created by Linus Liang on 1/7/16.
//  Copyright © 2016 Linus Liang. All rights reserved.
//

import UIKit
import CoreLocation


class CheckpointTableViewController: UITableViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    var locationManager: CLLocationManager!
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        let authorizedStatuses:[CLAuthorizationStatus] = [.AuthorizedAlways, .AuthorizedWhenInUse]
        if !authorizedStatuses.contains(CLLocationManager.authorizationStatus()) {
            print("couldn't get authorization")
            locationManager.requestWhenInUseAuthorization()
        }
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        //remove the separator lines when there are no extra cells
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .None
    }

    func setupCreateCheckpointCell(cell: CreateCheckpointTableViewCell) {
        cell.selectionStyle = .None
        cell.foodButton.addTarget(self, action: "buttonSelected:", forControlEvents: .TouchUpInside)
        cell.drinksButton.addTarget(self, action: "buttonSelected:", forControlEvents: .TouchUpInside)
        cell.scenicButton.addTarget(self, action: "buttonSelected:", forControlEvents: .TouchUpInside)
        cell.socialButton.addTarget(self, action: "buttonSelected:", forControlEvents: .TouchUpInside)
        cell.otherButton.addTarget(self, action: "buttonSelected:", forControlEvents: .TouchUpInside)
        cell.titleTextField.delegate = self
        
        cell.clipsToBounds = false
        let savingView = NSBundle.mainBundle().loadNibNamed("SavingView", owner: self, options: nil).first as! SavingView
        savingView.frame = CGRect(x: 0, y: savingView.frame.height - cell.frame.height/2, width: cell.frame.width, height: cell.frame.height/2)
        
        cell.addSubview(savingView)
    }
    
    func buttonSelected(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if(indexPath.row == 0) {
            cell = tableView.dequeueReusableCellWithIdentifier("Create Checkpoint Cell", forIndexPath: indexPath)
            setupCreateCheckpointCell(cell as! CreateCheckpointTableViewCell)
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("Checkpoint Cell", forIndexPath: indexPath)
            cell.backgroundColor = UIColor.grayColor()
            
        }
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 { return SCREENHEIGHT/2 }
        return SCREENHEIGHT/10
    }

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
