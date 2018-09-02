//
//  MainViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 30/07/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let appTitle: UILabel = {
        let label = UILabel()
        
        var title = NSMutableAttributedString(string: "PickUp\n", attributes: [
                NSAttributedStringKey.foregroundColor : UIColor.darkGray,
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 60)
            ])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let subtitle = NSMutableAttributedString(string: NSLocalizedString("Drive where you want", comment: ""), attributes: [
                NSAttributedStringKey.foregroundColor : UIColor.gray,
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15),
                NSAttributedStringKey.paragraphStyle : paragraphStyle
            ])
        
        title.append(subtitle)
        label.attributedText = title
        
        label.numberOfLines = 0
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cLightBlue
        button.setTitle(NSLocalizedString("Sign Up", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.makeShadowRounded(radius: 25)
        button.addTarget(self, action: #selector(presentSignUp), for: .touchUpInside)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.cLightBlue.cgColor
        button.layer.borderWidth = 0.5        
        button.setTitle(NSLocalizedString("Sign In", comment: ""), for: .normal)
        button.setTitleColor(.cLightBlue, for: .normal)
        button.makeShadowRounded(radius: 25)
        button.addTarget(self, action: #selector(presentSignIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        registerButton.makeGradientView()
        registerButton.clipsToBounds = true
    }
    
    @objc func presentSignUp() {
        let registrationVC = RegisterViewController()
        presentDetail(registrationVC)
    }
    
    @objc func presentSignIn() {
        let loginVC = LoginViewController()
        presentDetail(loginVC)
    }
}

extension MainViewController {
    fileprivate func addSubviews() {
        view.backgroundColor = .cWhite
        
        view.addSubview(logoImageView)
        view.addSubview(appTitle)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
    }
    
    fileprivate func makeConstraints() {
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(120)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(175)
        }
        
        appTitle.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(25)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(appTitle.snp.bottom).offset(50)
            make.leading.equalTo(view.snp.leading).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(registerButton.snp.bottom).offset(25)
            make.leading.equalTo(registerButton.snp.leading)
            make.trailing.equalTo(registerButton.snp.trailing)
            make.height.equalTo(registerButton.snp.height)
        }
    }
}
