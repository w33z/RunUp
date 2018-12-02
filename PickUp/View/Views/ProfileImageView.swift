//
//  ProfileImageView.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 02/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class ProfileImageView: UIView {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    fileprivate func setupView() {
        isUserInteractionEnabled = true
        profileImage.makeShadowRounded(radius: 40)
        profileImage.clipsToBounds = true
        
        fullnameLabel.adjustsFontSizeToFitWidth = true
        fullnameLabel.minimumScaleFactor = 0.5
    }
    
    func configureView(user: User) {
        fullnameLabel.text = user.fullname
        profileImage.loadImageUsingCache(urlString: user.profilePicURL)
    }
}
