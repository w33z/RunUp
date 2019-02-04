//
//  ShakeAnimationView.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 22/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit.UIView

extension UIView {
    func addShakeAnimation() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 5, y: center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: center.x + 5, y: center.y))
        layer.add(shake, forKey: "position")
    }
    
    func removeShakeAnimation() {
        layer.removeAnimation(forKey: "position")
    }
}
