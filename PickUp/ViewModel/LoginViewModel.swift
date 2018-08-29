//
//  LoginViewModel.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 25/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let disposeBag = DisposeBag()
    
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    let validationLoginError = BehaviorRelay<String>(value: "")
    let validationLoginSuccess = BehaviorRelay<String>(value: "")
    var event = PublishSubject<Event>()
    
    var isUsernameValid: Bool!
    var isPasswordValid: Bool!
    
    var loginButtonTappedEvent: ControlEvent<()>? {
        didSet {
            loginButtonTappedEvent?.subscribe({ (_) in
                if self.validateLoginData() {
                    var subscripeEvent = Event(type: .loginButtonTappedEvent)
                    self.event.onNext(subscripeEvent)
                    
                    AuthService.instance.loginUser(username: self.username.value.lowercased(), password: self.password.value, completion: { (status, error) in
                        
                        if status {
                            self.validationLoginSuccess.accept(NSLocalizedString("Login successful", comment: ""))
                            subscripeEvent = Event(type: .loginSuccess)
                            self.event.onNext(subscripeEvent)
                        } else {
                            self.validationLoginError.accept(NSLocalizedString(error!.localizedDescription, comment: ""))
                            subscripeEvent = Event(type: .loginError)
                            self.event.onNext(subscripeEvent)
                        }
                    })
                    
                } else {
                    if (!self.isUsernameValid) {
                        self.validationLoginError.accept(NSLocalizedString("Invalid Username", comment: ""))
                        let subscripeEvent = Event(type: .invalidUsername)
                        self.event.onNext(subscripeEvent)
                    }
                    if (!self.isPasswordValid) {
                        self.validationLoginError.accept(NSLocalizedString("Password must contain at least 8 characters, lowercase, uppercase and special character", comment: ""))
                        let subscripeEvent = Event(type: .invalidPassword)
                        self.event.onNext(subscripeEvent)
                    }
                }
            }).disposed(by: disposeBag)
        }
    }
    
    func validateLoginData() -> Bool {
        var isValidate = true
        isUsernameValid = true
        isPasswordValid = true
        
        if (username.value == "") {
            isUsernameValid = false
            isValidate = false
        }
        
        if (password.value == "" || !self.validatePassword(password: password.value)) {
            isPasswordValid = false
            isValidate = false
        }
        
        return isValidate
    }
    
    private func validatePassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~]).{8,}$"
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    
}
