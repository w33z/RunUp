//
//  LeftSidePanelTableViewCell.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 02/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class LeftSidePanelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var settingNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(menuItem: MenuItem) {
        iconImageView.image = UIImage(named: menuItem.imageName)?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.lightGray
        settingNameLabel.text = menuItem.title
    }
}
