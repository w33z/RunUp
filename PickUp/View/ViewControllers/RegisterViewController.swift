//
//  RegisterViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 09/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import BEMCheckBox

class RegisterViewController: BaseViewController {
    
    private let fullnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("Fullname", comment: "")
        textField.addBottomBorder(color: .lightGray, thickness: 0.25)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFit
        
        textField.rightView = imageView
        textField.rightViewMode = .always
        return textField
    }()
    
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
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.addBottomBorder(color: .lightGray, thickness: 0.25)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = UIImage(named: "mail")
        imageView.contentMode = .scaleAspectFit

        
        textField.rightView = imageView
        textField.rightViewMode = .always
        textField.keyboardType = .emailAddress
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
    
    private let genderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gender")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cLightBlue
        button.setTitle(NSLocalizedString("Sign Up", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.makeShadowRounded()
        return button
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cBlue
    
        let signUpAttributedString = NSMutableAttributedString(string: NSLocalizedString("Sign Up With ", comment: ""), attributes: [
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
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let forgotAttributedString = NSMutableAttributedString(string: NSLocalizedString("Already have an account? ", comment: ""), attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.gray,
            NSAttributedStringKey.paragraphStyle : paragraphStyle,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)
            ])
        
        let signInAttributedString = NSAttributedString(string: NSLocalizedString("Sign In", comment: ""), attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.gray,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)
            ])
        
        forgotAttributedString.append(signInAttributedString)
        label.attributedText = forgotAttributedString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentSignIn(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    var checkboxes: GenderCheckboxesView!
    let viewmodel: RegistrationViewModel = RegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        makeConstraints()
        bind()
        
        checkboxes.maleCheckbox.delegate = self
        checkboxes.femaleCheckbox.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        registerButton.makeGradientView()
        registerButton.clipsToBounds = true
    }
    
    @objc func presentSignIn(_ sender: UITapGestureRecognizer) {
        let loginVC = LoginViewController()
        presentDetail(loginVC)
    }
}

extension RegisterViewController: UITextFieldDelegate {
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

extension RegisterViewController: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        checkboxes.group.mustHaveSelection = true
        checkboxes.title = (checkBox.tag == 0) ? CheckBoxType.male : CheckBoxType.female
        
        viewmodel.gender.accept(checkboxes.title.rawValue)
    }
}

extension RegisterViewController {
    fileprivate func addSubviews() {

        backgroundView.addSubview(fullnameTextField)
        backgroundView.addSubview(usernameTextField)
        backgroundView.addSubview(emailTextField)
        backgroundView.addSubview(passwordTextField)
        backgroundView.addSubview(genderImageView)
        
        checkboxes = UIView.instanceFromNib(name: "GenderCheckboxes") as! GenderCheckboxesView
        
        backgroundView.addSubview(checkboxes)
        backgroundView.addSubview(registerButton)
        view.addSubview(facebookButton)
        view.addSubview(backLabel)
    }
    
    fileprivate func makeConstraints() {
        
        fullnameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(view.frame.height / 18)
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
            make.trailing.equalTo(passwordTextField)
            make.width.height.equalTo(18)
        }
        
        checkboxes.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom)
            make.leading.greaterThanOrEqualTo(passwordTextField).offset(0)
            make.leading.lessThanOrEqualTo(passwordTextField).offset(25)
            make.right.greaterThanOrEqualTo(passwordTextField).offset(-35)
            make.height.equalTo(45)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView.snp.bottom).offset(-25)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
            make.height.equalTo(50)
        }
        
        facebookButton.snp.makeConstraints { (make) in
            make.top.equalTo(registerButton.snp.bottom).offset(15)
            make.leading.trailing.height.equalTo(registerButton)
        }
        
        backLabel.snp.makeConstraints { (make) in
            make.top.equalTo(facebookButton.snp.bottom)
            make.leading.trailing.equalTo(facebookButton)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    fileprivate func bind() {
        fullnameTextField.rx.text
            .orEmpty
            .bind(to: viewmodel.fullname)
            .disposed(by: viewmodel.disposeBag)
        
        usernameTextField.rx.text
            .orEmpty
            .bind(to: viewmodel.username)
            .disposed(by: viewmodel.disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewmodel.email)
            .disposed(by: viewmodel.disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewmodel.password)
            .disposed(by: viewmodel.disposeBag)
        
        viewmodel.registerButtonTappedEvent = registerButton.rx.tap
        
        viewmodel.event.subscribe(onNext: { (event) in
            
           switch event.type {
                case .registerButtonTappedEvent:
                    self.startAnimating(message: NSLocalizedString("Loading...", comment: ""))
                    [self.fullnameTextField, self.usernameTextField, self.emailTextField, self.passwordTextField].forEach({ $0.removeShakeAnimation() })

                case .registerSuccess:
                    self.stopAnimating()
                    self.showAlertController(title: NSLocalizedString("Congratulations!", comment: ""), message: self.viewmodel.validationRegistrationSuccess.value)

                case .registerError:
                    self.stopAnimating()
                    [self.fullnameTextField,self.usernameTextField,self.emailTextField,self.passwordTextField].forEach({ $0.addShakeAnimation() })
                    self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: self.viewmodel.validationRegistrationError.value)

                case .invalidRegisterFullname:
                    self.fullnameTextField.addShakeAnimation()
                    self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: self.viewmodel.validationRegistrationError.value)

                case .invalidRegisterUsername:
                    self.usernameTextField.addShakeAnimation()
                    self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: self.viewmodel.validationRegistrationError.value)

                case .invalidRegisterEmail:
                    self.emailTextField.addShakeAnimation()
                    self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: self.viewmodel.validationRegistrationError.value)

                case .invalidRegisterPassword:
                    self.passwordTextField.addShakeAnimation()
                    self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: self.viewmodel.validationRegistrationError.value)

                case .invalidRegisterGender:
                    self.checkboxes.addShakeAnimation()
                    self.showAlertController(title: NSLocalizedString("Failure!", comment: ""), message: self.viewmodel.validationRegistrationError.value)
                default:
                    break
            }
        }).disposed(by: viewmodel.disposeBag)
    }
}
