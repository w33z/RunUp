//
//  ProfileViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 02/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var menuButton: UIButton = {
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "cancel"), for: .normal)
        leftButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        return leftButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        addSubviews()
        addConstraints()
    }

    @objc func menuButtonTapped() {
        dismissRevealDetail()
    }

}

extension ProfileViewController {
    
    fileprivate func addSubviews() {
        
        view.addSubview(menuButton)
    }
    
    fileprivate func addConstraints() {
        
        menuButton.snp.makeConstraints({ (make) in
            make.top.equalTo(view).offset(60)
            make.leading.equalTo(view).offset(25)
            make.width.height.equalTo(20)
        })
    }
}
