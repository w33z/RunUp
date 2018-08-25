//
//  ResetPasswordViewController.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 15/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

class ResetPasswordViewController: BaseViewController {
    
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
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cLightBlue
        button.setTitle(NSLocalizedString("Reset", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.makeShadowRounded()
        return button
    }()
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let forgotAttributedString = NSAttributedString(string: NSLocalizedString("Back to login", comment: ""), attributes: [
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
        
        resetButton.makeGradientView()
        resetButton.clipsToBounds = true
    }
    
    @objc func dismissResetPassword(_ sender: UITapGestureRecognizer) {
        dismissDetail()
    }
}

extension ResetPasswordViewController {
    fileprivate func addSubviews() {
        titleLabel.text = NSLocalizedString("Reset Password", comment: "")
        backgroundViewHeightConsraint?.update(offset: view.frame.height / 4.3)
        
        backgroundView.addSubview(usernameTextField)
        backgroundView.addSubview(emailTextField)
        backgroundView.addSubview(resetButton)
        view.addSubview(backLabel)
    }
    
    fileprivate func makeConstraints() {
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView).offset(25)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(view.frame.height / 18)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.leading.trailing.height.equalTo(usernameTextField)
        }
        
        resetButton.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView.snp.bottom).offset(-25)
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
