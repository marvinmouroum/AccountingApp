//
//  CustomeTableHeader.swift
//  Prototype_2
//
//  Created by Marvin Mouroum on 17.02.19.
//  Copyright © 2019 LCR. All rights reserved.
//

import UIKit

class CustomeTableHeader: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    
        let rectN:CGRect = CGRect(x: rect.width * 0.05, y: rect.height * 0.05,
                                  width: rect.width * 0.9, height: rect.height * 0.9)
        let background = UIBezierPath(roundedRect: rectN, byRoundingCorners: .allCorners, cornerRadii:
            CGSize(width:rect.height/6,height:rect.height/6))
        
        setTitle(title, for: .normal)
        
        if !isSelected{
            Design.lightBlue.setFill()
             titleLabel?.textColor = Design.darkBlue
        }
        else {
            Design.darkBlue.setFill()
            titleLabel?.textColor = .white
        }
        
        background.fill()
        
    }
    
    var title:String?
    
    func connect(){
        addTarget(self, action: #selector(clicked), for: .touchUpInside)
    }
    
    @objc func clicked(){
        self.isSelected = !isSelected
        self.setNeedsDisplay()
        self.layoutIfNeeded()
    }
 

}
