//
//  ProfileViewController.swift
//  RunUp
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
    
    var profileDetailsView: ProfileDetailsView = {
        let view = UIView.instanceFromNib(name: "ProfileDetailsView") as! ProfileDetailsView
        return view
    }()
    
    let viewmodel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addSubviews()
        addConstraints()
        
        if let user = viewmodel.user {
            profileImageView.configureView(user: user)
            profileDetailsView.configureView(user: user)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDidUpdate), name: Notification.Name.UserDidUpdateNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundView.makeGradientView()
    }
    
    @objc fileprivate func userDidUpdate() {
    
        guard let height = Int(profileDetailsView.heightTextField.text!), let weight = Int(profileDetailsView.weightTextField.text!) else { return }
        
        viewmodel.updateUser(height: height, weight: weight)
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
        view.addSubview(profileDetailsView)
    }
    
    fileprivate func addConstraints() {
        
        backgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 3.5)
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().offset(-5)
        }
        
        profileDetailsView.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension Notification.Name {
    static let UserDidUpdateNotification = Notification.Name("UserDidUpdateNotification")
}
