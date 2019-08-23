//
//  BezierVisualizer.swift
//  Prototype
//
//  Created by MacBook Pro Accounting  on 28.12.17.
//  Copyright © 2017 LCR. All rights reserved.
//

import UIKit

class BezierVisualizer: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = bezier
        UIColor.black.setStroke()
        path.stroke()
    }
    
    init(path: UIBezierPath, rect:CGRect){
        self.bezier = path
        super.init(frame: rect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bezier:UIBezierPath
}
