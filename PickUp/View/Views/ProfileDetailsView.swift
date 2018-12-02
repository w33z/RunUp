//
//  ProfileDetailsView.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 20/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class ProfileDetailsView: UIView {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        heightTextField.delegate = self
        weightTextField.delegate = self
    }

    func configureView(user: User) {
        
        usernameLabel.text = user.username

        if user.username.isEmpty {
            usernameLabel.textColor = UIColor.lightGray.withAlphaComponent(0.35)
            usernameLabel.text = "Missing username"
        }
        
        emailLabel.text = user.email
        genderLabel.text = user.gender
    }
}

extension ProfileDetailsView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: Notification.Name.UserDidUpdateNotification, object: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        return count <= 3
    }
}
