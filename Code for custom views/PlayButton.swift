//
//  PlayButton.swift
//  Prototype
//
//  Created by MacBook Pro Accounting  on 30.12.17.
//  Copyright © 2017 LCR. All rights reserved.
//

import UIKit

class PlayButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let path = UIBezierPath()
        path.move(to: rect.origin)
        path.addLine(to: CGPoint(x:0,y:rect.height))
        path.addLine(to: CGPoint(x:rect.height/2,y:rect.height/2))
        path.addLine(to: rect.origin)
        Design.smoothRed.setFill()
        path.fill()
        Design.smoothRed.setStroke()
        path.stroke()
    }

}
