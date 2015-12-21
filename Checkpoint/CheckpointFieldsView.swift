//
//  CheckpointFieldsView.swift
//  Checkpoint
//
//  Created by Linus Liang on 12/17/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import Foundation
import UIKit

protocol CheckpointFieldsViewDelegate {
    func checkpointSaved(success: Bool)
}

class CheckpointFieldsView: UIView, UITextFieldDelegate {
    
    final let selected = true
    
    @IBOutlet weak var titleTextField: UITextField! {
        didSet {
            titleTextField.delegate = self
        }
    }
    
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var drinksButton: UIButton!
    @IBOutlet weak var scenicButton: UIButton!
    @IBOutlet weak var socialButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        print("save button tapped")
        delegate?.checkpointSaved(true)
    }
    
    var delegate: CheckpointFieldsViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.darkGrayColor().CGColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowOpacity = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupButtons()
    }
    
    func setupButtons() {
        let reasonButtons = [self.foodButton, self.drinksButton, self.scenicButton, self.socialButton, self.otherButton]
        for button in reasonButtons {
            styleButton(button)
            button.addTarget(self, action: "setSelected:", forControlEvents: .TouchUpInside)
        }
    }
    
    func styleButton(button: UIButton) {
        button.layer.cornerRadius = 5
    }
    
    func setSelected(button: UIButton) {
        button.selected = !button.selected
    }
    
    // MARK - UITextFieldDelegate 
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
