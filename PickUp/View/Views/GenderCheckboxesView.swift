//
//  GenderCheckboxesView.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 12/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import BEMCheckBox

class GenderCheckboxesView: UIView {
    
    @IBOutlet weak var maleCheckbox: BEMCheckBox!
    @IBOutlet weak var femaleCheckbox: BEMCheckBox!
    
    var group: BEMCheckBoxGroup!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        group = BEMCheckBoxGroup(checkBoxes: [maleCheckbox, femaleCheckbox])
        group.selectedCheckBox = maleCheckbox
    }
}
