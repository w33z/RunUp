//
//  GenderCheckboxesView.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 12/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import BEMCheckBox

enum CheckBoxType: String {
    case male = "Male"
    case female = "Female"
}

class GenderCheckboxesView: UIView {
    
    @IBOutlet weak var maleCheckbox: BEMCheckBox!
    @IBOutlet weak var femaleCheckbox: BEMCheckBox!
    
    var group: BEMCheckBoxGroup!
    var title: CheckBoxType = .male
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        maleCheckbox.tag = 0
        femaleCheckbox.tag = 1
        
        group = BEMCheckBoxGroup(checkBoxes: [maleCheckbox, femaleCheckbox])
    }
}
