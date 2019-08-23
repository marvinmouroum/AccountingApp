//
//  ProgressBar.swift
//  Prototype
//
//  Created by MacBook Pro Accounting  on 03.01.18.
//  Copyright © 2018 LCR. All rights reserved.
//

import UIKit

class ProgressBar: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height/2)
        UIColor.white.setFill()
        path.fill()
        Design.darkBlue.setStroke()
        path.stroke()
        
        let pathLine = UIBezierPath()
        pathLine.move(to: CGPoint(x:rect.height/2,y:rect.height/2))
        pathLine.addLine(to: CGPoint(x:rect.width-rect.height/2,y:rect.height/2))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = Design.darkBlue.cgColor
        shapeLayer.lineWidth = rect.height
        shapeLayer.path = pathLine.cgPath
        shapeLayer.lineCap = convertToCAShapeLayerLineCap("round")
        shapeLayer.opacity = 0
        self.layer.addSublayer(shapeLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(1)) {
            shapeLayer.opacity = 1
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = self.animationTime
            shapeLayer.add(animation, forKey: "fillup")
        }
        
    }

    init(time:Double){
        self.animationTime = time
        super.init(frame: CGRect())
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var animationTime:Double

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCAShapeLayerLineCap(_ input: String) -> CAShapeLayerLineCap {
	return CAShapeLayerLineCap(rawValue: input)
}
