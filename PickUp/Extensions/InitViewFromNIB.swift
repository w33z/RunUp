//
//  InitViewFromNIB.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 09/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit.UIView

extension UIView {
    
    class func instanceFromNib(name: String) -> UIView {
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
