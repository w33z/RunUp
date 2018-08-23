//
//  LoginViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 16/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let logoBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    private let resetBGView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.makeShadowRounded()
        return view
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username.."
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
        textField.placeholder = "Password.."
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
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.makeShadowRounded()
        return button
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cBlue
        
        let signUpAttributedString = NSMutableAttributedString(string: "Sign In With ", attributes: [
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
        
        let dontHaveAttributedString = NSMutableAttributedString(string: "Don't Have an Account? ", attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.gray,
            NSAttributedStringKey.paragraphStyle : paragraphStyle,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)
            ])
        
        let signUpAttributedString = NSAttributedString(string: "Sign Up", attributes: [
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

        let forgotAttributedString = NSMutableAttributedString(string: "Forgot password? ", attributes: [
                NSAttributedStringKey.foregroundColor : UIColor.gray,
                NSAttributedStringKey.paragraphStyle : paragraphStyle,
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)
            ])
        
        let resetAttributedString = NSAttributedString(string: "Reset", attributes: [
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
        
        gradientView.makeGradientView()
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
        view.backgroundColor = .cWhite
        
        view.addSubview(gradientView)
        view.addSubview(logoBGView)
        logoBGView.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(resetBGView)
        resetBGView.addSubview(usernameTextField)
        resetBGView.addSubview(passwordTextField)
        resetBGView.addSubview(signInButton)
        resetBGView.addSubview(facebookButton)
        view.addSubview(restorePasswordLabel)
        view.addSubview(dontHaveAccountLabel)
    }
    
    fileprivate func makeConstraints() {
        gradientView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 2)
        }
        
        logoBGView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(view.frame.height / 12)
            make.centerX.equalTo(view)
            make.width.height.equalTo(120)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(10, 5, 5, 10))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoBGView.snp.bottom).offset(20)
            make.centerX.equalTo(logoBGView)
        }
        
        resetBGView.snp.makeConstraints { (make) in
            make.top.equalTo(gradientView.snp.bottom).offset(-80)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(view.frame.height / 3)
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(resetBGView).offset(25)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(view.frame.height / 18)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.leading.trailing.height.equalTo(usernameTextField)
        }
        
        facebookButton.snp.makeConstraints { (make) in
            make.top.equalTo(resetBGView.snp.bottom).offset(-25)
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
//        usernameTextField.rx.text
//            .orEmpty
//            .bind(to: <#T##BehaviorRelay<String>#>)
    }
}
