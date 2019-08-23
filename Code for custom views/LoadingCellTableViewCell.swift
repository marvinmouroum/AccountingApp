//
//  LoadingCellTableViewCell.swift
//  Prototype_2
//
//  Created by Marvin Mouroum on 18.02.19.
//  Copyright © 2019 LCR. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingCellTableViewCell: UITableViewCell {

    
    override func draw(_ rect: CGRect) {
        let rectN:CGRect = CGRect(x: rect.width * 0.05, y: rect.height * 0.05,
                                  width: rect.width * 0.9, height: rect.height * 0.9)
        let background = UIBezierPath(roundedRect: rectN, byRoundingCorners: .allCorners, cornerRadii: CGSize(width:5,height:5))
        Design.lightBlue.setFill()
        background.fill()
    }
    
    lazy var indicator_view:NVActivityIndicatorView = {
        let width = min(self.frame.width*0.75,self.frame.height*0.75)
        let center = CGPoint(x:self.frame.width/2,y:self.frame.height/2)
        let indicator_size = CGSize(width:width,height:width)
        let indicator_origin = CGPoint(x:center.x-width/2,y:center.y-width/2)
        let indicator = NVActivityIndicatorView(
            frame: CGRect(origin:indicator_origin, size:indicator_size),
            type: .ballScaleRippleMultiple,
            color: Design.darkBlue, padding: nil)
        return indicator
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
