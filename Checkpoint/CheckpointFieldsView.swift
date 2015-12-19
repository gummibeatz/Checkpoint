//
//  CheckpointFieldsView.swift
//  Checkpoint
//
//  Created by Linus Liang on 12/17/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import Foundation
import UIKit

class CheckpointFieldsView: UIView {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var drinksButton: UIButton!
    @IBOutlet weak var scenicButton: UIButton!
    @IBOutlet weak var socialButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
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
}
