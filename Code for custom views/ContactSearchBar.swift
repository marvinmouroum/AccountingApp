//
//  PickDuelPartnerViewController.swift
//  Prototype
//
//  Created by MacBook Pro Accounting  on 30.12.17.
//  Copyright © 2017 LCR. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class ContactSearchBar: UITextField {
    
    init (){
        super.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: bounds.width*0.15))
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15))
    }
    
}
