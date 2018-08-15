//
//  ResetPasswordViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 15/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

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
        label.text = "Reset Password"
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
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cLightBlue
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.makeShadowRounded()
        return button
    }()
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let forgotAttributedString = NSAttributedString(string: "Back to login", attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.gray,
            NSAttributedStringKey.paragraphStyle : paragraphStyle,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)
            ])
        
        label.attributedText = forgotAttributedString
        label.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissResetPassword(_:)))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientView.makeGradientView()
        resetButton.makeGradientView()
        resetButton.clipsToBounds = true
    }
    
    @objc func dismissResetPassword(_ sender: UITapGestureRecognizer) {
        let presentingViewController = self.presentingViewController
        self.dismissDetail {
            presentingViewController?.dismissDetail()
        }
    }
}

extension ResetPasswordViewController {
    fileprivate func addSubviews() {
        view.backgroundColor = .cWhite
        
        view.addSubview(gradientView)
        view.addSubview(logoBGView)
        logoBGView.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(resetBGView)
        resetBGView.addSubview(usernameTextField)
        resetBGView.addSubview(emailTextField)
        resetBGView.addSubview(resetButton)
        view.addSubview(backLabel)
    }
    
    fileprivate func makeConstraints() {
        gradientView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 2)
        }
        
        logoBGView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
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
            make.height.equalTo(180)
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(resetBGView).offset(25)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.leading.trailing.height.equalTo(usernameTextField)
        }
        
        resetButton.snp.makeConstraints { (make) in
            make.top.equalTo(resetBGView.snp.bottom).offset(-25)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
            make.height.equalTo(50)
        }
        
        backLabel.snp.makeConstraints { (make) in
            make.top.equalTo(resetButton.snp.bottom).offset(15)
            make.leading.trailing.equalTo(resetButton)
        }
    }
}
