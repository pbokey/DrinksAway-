//
//  UIButtonExtension.swift
//  DrinksAway!
//
//  Created by Pranav Bokey on 5/7/18.
//  Copyright © 2018 Pranav Bokey. All rights reserved.
//

import UIKit
import Foundation

extension UIButton {
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.0
        shake.repeatCount = 0
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.9
        pulse.toValue = 1.1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.4
        pulse.damping = 0
        
        layer.add(pulse, forKey: nil)
    }
}
