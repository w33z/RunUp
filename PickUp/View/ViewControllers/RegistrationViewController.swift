//
//  RegistrationViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 09/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import BEMCheckBox

class RegistrationViewController: UIViewController {
    
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
        label.text = "Sign Up"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    private let registerBGView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.makeShadowRounded()
        return view
    }()
    
    private let fullnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Fullname.."
        textField.addBottomBorder(color: .lightGray, thickness: 0.25)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = UIImage(named: "profile")
        
        textField.rightView = imageView
        textField.rightViewMode = .always
        return textField
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username.."
        textField.addBottomBorder(color: .lightGray, thickness: 0.25)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = UIImage(named: "username")
        
        textField.rightView = imageView
        textField.rightViewMode = .always
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email.."
        textField.addBottomBorder(color: .lightGray, thickness: 0.25)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = UIImage(named: "mail")
        
        textField.rightView = imageView
        textField.rightViewMode = .always
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password.."
        textField.addBottomBorder(color: .lightGray, thickness: 0.25)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = UIImage(named: "view")
        
        textField.rightView = imageView
        textField.rightViewMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let genderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gender")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.customLightBlue
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.makeShadowRounded()
        return button
    }()
    
    var checkbox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullnameTextField.delegate = self
        
        addSubviews()
        makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientView.makeGradientView()
        signUpButton.makeGradientView()
        signUpButton.clipsToBounds = true
    }
    
    fileprivate func addSubviews() {
        view.backgroundColor = .customWhite
        
        view.addSubview(gradientView)
        view.addSubview(logoBGView)
        logoBGView.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(registerBGView)
        registerBGView.addSubview(fullnameTextField)
        registerBGView.addSubview(usernameTextField)
        registerBGView.addSubview(emailTextField)
        registerBGView.addSubview(passwordTextField)
        registerBGView.addSubview(genderImageView)
        
        checkbox = UIView.instanceFromNib(name: "GenderCheckboxes")
        registerBGView.addSubview(checkbox)
        registerBGView.addSubview(signUpButton)
    }
    
    fileprivate func makeConstraints() {
        
        gradientView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 2)
        }
        
        logoBGView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(120)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(10, 5, 5, 10))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoBGView.snp.bottom).offset(20)
            make.centerX.equalTo(logoBGView.snp.centerX)
        }
        
        registerBGView.snp.makeConstraints { (make) in
            make.top.equalTo(gradientView.snp.bottom).offset(-80)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(280)
        }
        
        fullnameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(registerBGView.snp.top).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(40)
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(fullnameTextField.snp.bottom).offset(10)
            make.leading.trailing.height.equalTo(fullnameTextField)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.leading.trailing.height.equalTo(usernameTextField)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.trailing.height.equalTo(emailTextField)
        }
        
        genderImageView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.right.equalTo(-15)
            make.width.height.equalTo(18)
        }
        
        checkbox.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.right.equalTo(genderImageView.snp.left).offset(-10)
            make.height.equalTo(45)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(registerBGView.snp.bottom).offset(-25)
            make.leading.equalTo(view.snp.leading).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
            make.height.equalTo(50)
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case fullnameTextField:
            fullnameTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing:")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        print("textFieldDidBeginEditing:")
    }
}
