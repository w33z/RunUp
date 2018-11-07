//
//  WorkoutButton.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 24/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

@IBDesignable class WorkoutButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        imageEdgeInsets =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        imageView?.image = imageView?.image?.withRenderingMode(.alwaysTemplate)
        imageView?.tintColor = UIColor.white
    }
}
