//
//  CreateCheckpointTableViewCell.swift
//  Checkpoint
//
//  Created by Linus Liang on 1/7/16.
//  Copyright © 2016 Linus Liang. All rights reserved.
//

import UIKit

class CreateCheckpointTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var drinksButton: UIButton!
    @IBOutlet weak var scenicButton: UIButton!
    @IBOutlet weak var socialButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
