//
//  CheckpointViewController.swift
//  Checkpoint
//
//  Created by Linus Liang on 1/8/16.
//  Copyright © 2016 Linus Liang. All rights reserved.
//

import UIKit

class CheckpointViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, LocationManagerDelegate {
    
    @IBOutlet weak var checkpointTextField: UITextField! {
        didSet {
            checkpointTextField.delegate = self
        }
    }
    
    @IBOutlet weak var foodButton: UIButton! {
        didSet {
            foodButton.addTarget(self, action: "isSelected:", forControlEvents: .TouchUpInside)
        }
    }
    @IBOutlet weak var drinksButton: UIButton! {
        didSet {
            drinksButton.addTarget(self, action: "isSelected:", forControlEvents: .TouchUpInside)
        }
    }
    @IBOutlet weak var scenicButton: UIButton! {
        didSet {
            scenicButton.addTarget(self, action: "isSelected:", forControlEvents: .TouchUpInside)
        }
    }
    @IBOutlet weak var socialButton: UIButton! {
        didSet {
            socialButton.addTarget(self, action: "isSelected:", forControlEvents: .TouchUpInside)
        }
        
    }
    @IBOutlet weak var otherButton: UIButton! {
        didSet {
            otherButton.addTarget(self, action: "isSelected:", forControlEvents: .TouchUpInside)
        }
    }
    
    @IBOutlet weak var checkpointTableView: UITableView! {
        didSet {
            checkpointTableView.delegate = self
            checkpointTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager().start()
    }
    
    func isSelected(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("checkpointCell", forIndexPath: indexPath) as! CheckpointTableViewCell
        cell.backgroundColor = UIColor.grayColor()
        cell.titleLabel.text = "Filler"
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SCREENHEIGHT/10
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
   
    // MARK: - LocationManagerDelegate
    func locationManagerDidUpdateLocations(manager: LocationManager) {
        print(manager.location?.coordinate)
    }
}
