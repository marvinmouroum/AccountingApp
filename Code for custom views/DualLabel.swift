//
//  DualLabel.swift
//  Prototype
//
//  Created by MacBook Pro Accounting  on 29.12.17.
//  Copyright © 2017 LCR. All rights reserved.
//

import UIKit

enum DualLabelSelectionState {
    case selected
    case deselected
}

class DualLabel: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.backgroundColor = .clear
        currentFrame = rect
        
        for view in subviews {
            if view.tag == 007 { view.removeFromSuperview() }
        }
        
        let rectPath = UIBezierPath(roundedRect: CGRect(x:1,y:1,width:rect.width-2,height:rect.height/2-2), cornerRadius: rect.height/4)
        
        
        if selectionState == .deselected {
            rectPath.lineWidth = 1
            Design.darkBlue.setStroke()
            rectPath.stroke()
        }else {
            rectPath.close()
            rectPath.lineWidth = 0
            let color = Design.darkBlue
            color.setFill()
            rectPath.fill()
        }
        
        let bubble = UIBezierPath(arcCenter: CGPoint(x:rect.width/2 ,y:rect.height*0.65), radius: rect.height*0.3, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
            
        if let color = bubbleColor { color.setFill() }
        else { Design.darkBlue.setFill() }
        bubble.fill()
        
        let textLabel = UILabel()
        textLabel.frame = CGRect(x:0,y:0,width:rect.width,height:rect.height/2)
        textLabel.textAlignment = .center
        textLabel.text = text
        if selectionState == .deselected { textLabel.textColor = Design.darkBlue }
        else { textLabel.textColor = .white }
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.font = UIFont(name:Design.defaultFont , size: Design.miniFontSize)
        self.addSubview(textLabel)
        
        let numberLabel = UILabel()
        numberLabel.tag = 007
        numberLabel.frame.size = CGSize(width:rect.height*0.35,height:rect.height*0.35)
        numberLabel.center = CGPoint(x:rect.width/2 ,y:rect.height*0.65)
        numberLabel.textAlignment = .center
        numberLabel.text = "\(number)"
        numberLabel.textColor = .white
        self.addSubview(numberLabel)
    }
 
    var bubbleColor:UIColor?
    var number:Int = 0
    var text:String = "challenges"
    private var selectionState:DualLabelSelectionState = .deselected
    public var isSelected:Bool { get { return selectionState == .selected } }
    private var currentFrame:CGRect?
    
    public func markSelected() {
        selectionState = .selected
        if currentFrame != nil {
            
            self.setNeedsDisplay()
            self.layoutIfNeeded()
            self.setNeedsDisplay(currentFrame ?? CGRect())
            
        }
    }
    public func markdeSelected() {
        selectionState = .deselected
        if currentFrame != nil {
            
            self.setNeedsDisplay()
            self.layoutIfNeeded()
            self.setNeedsDisplay(currentFrame ?? CGRect())

        }
    }

}
