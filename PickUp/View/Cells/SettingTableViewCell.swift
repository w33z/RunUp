//
//  SettingTableViewCell.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 27/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let REUSE_IDENTIFIER = "SettingTableViewCellReuseIdentifier"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        settingSwitch.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(title: String, options: SettingOptions?) {
        
        titleLabel.text = title
        guard let subtitle = options?.rawValue else { return }
        subTitleLabel.text = subtitle
    }
    
    func showSwitch() {
        subTitleLabel.isHidden = true
        settingSwitch.isHidden = false
    }
    
    func hideSwitch() {
        subTitleLabel.isHidden = false
        settingSwitch.isHidden = true
    }
    
    @objc func toggleSwitch() {
        settingSwitch.setOn(!settingSwitch.isOn, animated: true)
        Settings.instance.satellite = !Settings.instance.satellite
    }
}
