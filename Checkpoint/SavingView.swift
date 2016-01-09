//
//  SavingView.swift
//  Checkpoint
//
//  Created by Linus Liang on 1/7/16.
//  Copyright © 2016 Linus Liang. All rights reserved.
//

import UIKit

class SavingView: UIView {
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var rightBar: UIView!
    
    let animationDuration = 2.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToWindow() {
        NSTimer.scheduledTimerWithTimeInterval(animationDuration, target: self, selector: "animateArrow", userInfo: nil, repeats: true).fire()
    }
    
    func animateArrow() {
        let duration = 3*animationDuration/4
        self.arrowImage.layer.opacity = 1
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut,
            animations: {
                self.arrowImage.transform = CGAffineTransformMakeTranslation(0,self.frame.height/2)
            }, completion: {
                completionHandler in
                self.arrowImage.transform = CGAffineTransformIdentity
        })
        UIView.animateWithDuration(duration/3, delay: 2*duration/3, options: .CurveEaseOut,
            animations: {
                self.arrowImage.layer.opacity = 0
            }, completion: nil)
    }

}
