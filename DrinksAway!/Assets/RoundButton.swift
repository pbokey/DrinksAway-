//
//  RoundButton.swift
//  DrinksAway!
//
//  Created by Pranav Bokey on 4/12/18.
//  Copyright © 2018 Pranav Bokey. All rights reserved.
//

import UIKit
@IBDesignable

class RoundButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var roundButton: Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
}
