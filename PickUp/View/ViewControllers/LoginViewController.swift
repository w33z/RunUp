//
//  LoginViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 16/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: BaseAuthViewController {
    
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cLightBlue
        button.setTitle(NSLocalizedString("Sign In", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.makeShadowRounded(radius: 25)
        return button
    }()
    
    private let facebookButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.backgroundColor = .cBlue
        
        let signUpAttributedString = NSMutableAttributedString(string: NSLocalizedString("Sign In With ", comment: ""), attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.white
            ])
        let facebookAttributedString = NSAttributedString(string: "Facebook", attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize),
            NSAttributedString.Key.foregroundColor : UIColor.white
            ])
        signUpAttributedString.append(facebookAttributedString)
        button.setAttributedTitle(signUpAttributedString, for: .normal)

        button.setTitleColor(.white, for: .normal)
        
        let layoutConstraintsArr = button.constraints
        for lc in layoutConstraintsArr {
            if (lc.constant == 28){
                lc.isActive = false
                break
            }
        }
        button.readPermissions = ["public_profile", "email"]
        button.makeShadowRounded(radius: 25)
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let dontHaveAttributedString = NSMutableAttributedString(string: NSLocalizedString("Don't Have an Account? ", comment: ""), attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.gray,
            NSAttributedString.Key.paragraphStyle : paragraphStyle,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)
            ])
        
        let signUpAttributedString = NSAttributedString(string: NSLocalizedString("Sign Up", comment: ""), attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.gray,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
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
                NSAttributedString.Key.foregroundColor : UIColor.gray,
                NSAttributedString.Key.paragraphStyle : paragraphStyle,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)
            ])
        
        let resetAttributedString = NSAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.gray,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
            ])
        
        forgotAttributedString.append(resetAttributedString)
        label.attributedText = forgotAttributedString

        let tap = UITapGestureRecognizer(target: self, action: #selector(presentResetPassword(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    let viewmodel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookButton.delegate = self
        
        addSubviews()
        makeConstraints()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        loginButton.makeGradientView()
        loginButton.clipsToBounds = true
    }
    
    @objc func presentSignInPassword(_ sender: UITapGestureRecognizer) {
        let registerVC = RegisterViewController()
        presentDetail(registerVC)
    }
    
    @objc func presentResetPassword(_ sender: UITapGestureRecognizer) {
        let resetVC = ResetPasswordViewController()
        presentDetail(resetVC)
    }
}

extension LoginViewController {
    fileprivate func addSubviews() {
        titleLabel.text = NSLocalizedString("Sign In", comment: "")
        self.backgroundViewHeightConsraint?.update(offset: view.frame.height / 3)

        backgroundView.addSubview(usernameTextField)
        backgroundView.addSubview(passwordTextField)
        backgroundView.addSubview(loginButton)
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
        
        loginButton.snp.makeConstraints { (make) in
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
        usernameTextField.rx.text
            .orEmpty
            .bind(to: viewmodel.username)
            .disposed(by: viewmodel.disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewmodel.password)
            .disposed(by: viewmodel.disposeBag)
        
        viewmodel.loginButtonTappedEvent = loginButton.rx.tap
        
        viewmodel.event.subscribe(onNext: { (event) in
            
            switch event.type {
                case .loginButtonTappedEvent:
                    self.startAnimating(message: NSLocalizedString("Loading...", comment: ""))
                    [self.usernameTextField, self.passwordTextField].forEach({ $0.removeShakeAnimation() })
                
                case .loginSuccess:
                    self.stopAnimating()
                    self.showAlertController(title: "", message: self.viewmodel.validationLoginSuccess.value)
                
                case .loginError:
                    self.stopAnimating()
                    [self.usernameTextField, self.passwordTextField].forEach({ $0.addShakeAnimation() })
                    self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: self.viewmodel.validationLoginError.value)

                case .invalidUsername:
                    self.usernameTextField.addShakeAnimation()
                    self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: self.viewmodel.validationLoginError.value)

                
                case .invalidPassword:
                    self.passwordTextField.addShakeAnimation()
                    self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: self.viewmodel.validationLoginError.value)

                default:
                    break
            }
        }).disposed(by: viewmodel.disposeBag)
    }
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        if ((error) != nil) {
            self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: error.localizedDescription)
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            if result.grantedPermissions.contains("public_profile") {
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,name,email,gender"]).start { (connection, result, error) in

                    if let error = error {
                        self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: error.localizedDescription)
                        return
                    }
                    
                    let userData = UserService.instance.parseUserFacebookData(result: result)
                    UserService.instance.setUserFacebookData(userData: userData)
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
}
