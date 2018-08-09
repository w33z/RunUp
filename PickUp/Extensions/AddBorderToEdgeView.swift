//
//  AddBorderToEdgeView.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 09/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

extension UIView {
    func addTopBorder(color: UIColor, thickness: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: thickness)
        addSubview(border)
    }
    
    func addBottomBorder(color: UIColor, thickness: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - thickness, width: frame.size.width, height: thickness)
        addSubview(border)
    }
    
    func addLeftBorder(color: UIColor, thickness: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.size.height)
        addSubview(border)
    }
    
    func addRightBorder(color: UIColor, thickness: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - thickness, y: 0, width: thickness, height: frame.size.height)
        addSubview(border)
    }
}
