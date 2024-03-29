//
//  ShadowRoundedView.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 08/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit.UIView

extension UIView {
    
    func makeShadowRounded(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.15
    }
}
