//
//  FadeToView.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 01/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit.UIView

extension UIView {
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
}
