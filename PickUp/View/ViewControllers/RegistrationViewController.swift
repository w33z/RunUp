//
//  RegistrationViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 09/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit
import BEMCheckBox
import RxSwift
import RxCocoa

class RegistrationViewController: BaseViewController {
    
    private let fullnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Fullname.."
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
        textField.placeholder = "Username.."
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
        textField.placeholder = "Email.."
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
    
    private let genderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gender")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cLightBlue
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.makeShadowRounded()
        return button
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cBlue
    
        let signUpAttributedString = NSMutableAttributedString(string: "Sign Up With ", attributes: [
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
        
        let forgotAttributedString = NSMutableAttributedString(string: "Already have an account? ", attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.gray,
            NSAttributedStringKey.paragraphStyle : paragraphStyle,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)
            ])
        
        let signInAttributedString = NSAttributedString(string: "Sign In", attributes: [
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
        
        signUpButton.makeGradientView()
        signUpButton.clipsToBounds = true
    }
    
    @objc func presentSignIn(_ sender: UITapGestureRecognizer) {
        let loginVC = LoginViewController()
        presentDetail(loginVC)
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

extension RegistrationViewController: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        checkboxes.title = (checkBox.tag == 0) ? CheckBoxType.male : CheckBoxType.female
        viewmodel.gender.accept(checkboxes.title.rawValue)
    }
}

extension RegistrationViewController {
    fileprivate func addSubviews() {

        backgroundView.addSubview(fullnameTextField)
        backgroundView.addSubview(usernameTextField)
        backgroundView.addSubview(emailTextField)
        backgroundView.addSubview(passwordTextField)
        backgroundView.addSubview(genderImageView)
        
        checkboxes = UIView.instanceFromNib(name: "GenderCheckboxes") as! GenderCheckboxesView
        
        backgroundView.addSubview(checkboxes)
        backgroundView.addSubview(signUpButton)
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
            make.leading.equalTo(passwordTextField).offset(25)
            make.right.equalTo(genderImageView.snp.left).offset(-25)
            make.height.equalTo(45)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView.snp.bottom).offset(-25)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
            make.height.equalTo(50)
        }
        
        facebookButton.snp.makeConstraints { (make) in
            make.top.equalTo(signUpButton.snp.bottom).offset(15)
            make.leading.trailing.height.equalTo(signUpButton)
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
        
        viewmodel.registerButtonTappedEvent = signUpButton.rx.tap
        
        viewmodel.event.subscribe(onNext: { (event) in
            
           switch event.type {
                case .registerButtonTappedEvent:
                    self.startAnimating(message: "Loading...")
                    [self.fullnameTextField,self.usernameTextField,self.emailTextField,self.passwordTextField].forEach({ $0.removeShakeAnimation() })

            case .registerSuccess:
                    self.stopAnimating()
                    self.showAlertController(title: "Congratulations!", message: self.viewmodel.validationRegistrationSuccess.value)

                case .registerError:
                    self.stopAnimating()
                    [self.fullnameTextField,self.usernameTextField,self.emailTextField,self.passwordTextField].forEach({ $0.addShakeAnimation() })
                    self.showAlertController(title: "Failure!", message: self.viewmodel.validationRegistrationError.value)

                case .invalidRegisterFullname:
                    self.fullnameTextField.addShakeAnimation()
                    self.showAlertController(title: "Failure!", message: self.viewmodel.validationRegistrationError.value)

                case .invalidRegisterUsername:
                    self.usernameTextField.addShakeAnimation()
                    self.showAlertController(title: "Failure!", message: self.viewmodel.validationRegistrationError.value)

                case .invalidRegisterEmail:
                    self.emailTextField.addShakeAnimation()
                    self.showAlertController(title: "Failure!", message: self.viewmodel.validationRegistrationError.value)

                case .invalidRegisterPassword:
                    self.passwordTextField.addShakeAnimation()
                    self.showAlertController(title: "Failure!", message: self.viewmodel.validationRegistrationError.value)

                case .invalidRegisterGender:
                    self.checkboxes.addShakeAnimation()
                    self.showAlertController(title: "Failure!", message: self.viewmodel.validationRegistrationError.value)

            }
        }).disposed(by: viewmodel.disposeBag)
    }
}
