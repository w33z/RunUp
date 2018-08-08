//
//  UIColor.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 08/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    static var iron: UIColor {
        return UIColor(r: 245, g: 245, b: 245)
    }

}
