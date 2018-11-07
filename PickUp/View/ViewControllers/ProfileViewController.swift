//
//  ProfileViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 02/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class ProfileViewController: BaseMenuViewController {
    
    private var backgroundView = UIView()
    
    var profileImageView: ProfileImageView = {
        let view = UIView.instanceFromNib(name: "ProfileImageView") as! ProfileImageView
        return view
    }()
    
    var profileDetailsView: UIView = {
//        let view = UIView.instanceFromNib(name: "ProfileDetailsView") as! ProfileDetailsView
        return UIView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addSubviews()
        addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundView.makeGradientView()
    }
}

extension ProfileViewController {
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Profile"
    }
    
    fileprivate func addSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(profileImageView)
    }
    
    fileprivate func addConstraints() {
        
        backgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 3.5)
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().offset(-25)
        }
    }
}
