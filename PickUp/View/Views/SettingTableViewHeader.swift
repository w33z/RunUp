//
//  SettingTableViewHeader.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 24/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class SettingTableViewHeader: UIView {
    
    static let REUSE_IDENTIFIER = "SettingTableViewHeaderReuseIdentifier"

    @IBOutlet weak var headerTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    fileprivate func setupView() {
        backgroundColor = .cBG
    }
}
