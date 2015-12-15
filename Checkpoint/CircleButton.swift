//
//  circleButton.swift
//  Checkpoint
//
//  Created by Linus Liang on 12/14/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import UIKit

@IBDesignable class CircleButton: UIButton {

    override func drawRect(rect: CGRect) {
        let borderWidth: CGFloat = 2
        let path = UIBezierPath(arcCenter: CGPoint(x: rect.width/2, y: rect.height/2), radius: min(rect.width/2,rect.height/2) - borderWidth, startAngle: 0, endAngle: 2 * π, clockwise: true)
        checkpointBlue.setStroke()
        checkpointBlue.setFill()
        path.stroke()
        path.fill()
        super.drawRect(rect)
    }

}
