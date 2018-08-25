//
//  LoginViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 16/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("Username", comment: "")
        textField.addBottomBorder(color: .lightGray, thickness: 0.25)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = UIImage(named: "username")
        imageView.contentMode = .scaleAspectFit
        
        
        textField.rightView = imageView
        textField.rightViewMode = .always
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("Password", comment: "")
        textField.addBottomBorder(color: .lightGray, thickness: 0.25)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = UIImage(named: "view")
        imageView.contentMode = .scaleAspectFit
        
        
        textField.rightView = imageView
        textField.rightViewMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cLightBlue
        button.setTitle(NSLocalizedString("Sign In", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.makeShadowRounded()
        return button
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cBlue
        
        let signUpAttributedString = NSMutableAttributedString(string: NSLocalizedString("Sign In With ", comment: ""), attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.white
            ])
        let facebookAttributedString = NSAttributedString(string: "Facebook", attributes: [
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize),
            NSAttributedStringKey.foregroundColor : UIColor.white
            ])
        signUpAttributedString.append(facebookAttributedString)
        button.setAttributedTitle(signUpAttributedString, for: .normal)
        
        
        button.setTitleColor(.white, for: .normal)
        button.makeShadowRounded()
        return button
    }()
    
    private lazy var dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let dontHaveAttributedString = NSMutableAttributedString(string: NSLocalizedString("Don't Have an Account? ", comment: ""), attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.gray,
            NSAttributedStringKey.paragraphStyle : paragraphStyle,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)
            ])
        
        let signUpAttributedString = NSAttributedString(string: NSLocalizedString("Sign Up", comment: ""), attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.gray,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)
            ])
        dontHaveAttributedString.append(signUpAttributedString)
        
        label.attributedText = dontHaveAttributedString
        label.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentSignInPassword(_:)))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    private lazy var restorePasswordLabel: UILabel = {
        let label = UILabel()

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let forgotAttributedString = NSMutableAttributedString(string: NSLocalizedString("Forgot password? ", comment: ""), attributes: [
                NSAttributedStringKey.foregroundColor : UIColor.gray,
                NSAttributedStringKey.paragraphStyle : paragraphStyle,
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)
            ])
        
        let resetAttributedString = NSAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.gray,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)
            ])
        
        forgotAttributedString.append(resetAttributedString)
        label.attributedText = forgotAttributedString

        let tap = UITapGestureRecognizer(target: self, action: #selector(presentResetPassword(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        makeConstraints()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        signInButton.makeGradientView()
        signInButton.clipsToBounds = true
    }
    
    @objc func presentSignInPassword(_ sender: UITapGestureRecognizer) {
        let registerVC = RegistrationViewController()
        presentDetail(registerVC)
    }
    
    @objc func presentResetPassword(_ sender: UITapGestureRecognizer) {
        let resetVC = ResetPasswordViewController()
        presentDetail(resetVC)
    }
}

extension LoginViewController {
    fileprivate func addSubviews() {
        titleLabel.text = "Sign In"
        self.backgroundViewHeightConsraint?.update(offset: view.frame.height / 3)

        backgroundView.addSubview(usernameTextField)
        backgroundView.addSubview(passwordTextField)
        backgroundView.addSubview(signInButton)
        backgroundView.addSubview(facebookButton)
        view.addSubview(restorePasswordLabel)
        view.addSubview(dontHaveAccountLabel)
    }
    
    fileprivate func makeConstraints() {
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView).offset(25)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(view.frame.height / 18)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.leading.trailing.height.equalTo(usernameTextField)
        }
        
        facebookButton.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView.snp.bottom).offset(-25)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
            make.height.equalTo(50)
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(facebookButton.snp.top).offset(-15)
            make.leading.trailing.equalTo(facebookButton)
            make.height.equalTo(facebookButton)
        }
        
        restorePasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(facebookButton.snp.bottom).offset(15)
            make.leading.trailing.equalTo(facebookButton)
        }
        
        dontHaveAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(restorePasswordLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(restorePasswordLabel)
        }
    }
    
    fileprivate func bind() {

    }
}
