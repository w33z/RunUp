//
//  RegistrationViewModel.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 18/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import BEMCheckBox

class RegistrationViewModel {
    
    let disposeBag = DisposeBag()
    
    let fullname = BehaviorRelay<String>(value: "")
    let username = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let gender = BehaviorRelay<String>(value: "")
    
    let validationRegistrationError = BehaviorRelay<String>(value: "")
    let validationRegistrationSuccess = BehaviorRelay<String>(value: "")
    var event = PublishSubject<Event>()
    
    var isFullnameValid: Bool!
    var isUsernameValid: Bool!
    var isEmailValid: Bool!
    var isPasswordValid: Bool!
    var isGenderValid: Bool!
    
    var registerButtonTappedEvent: ControlEvent<()>? {
        didSet {
            registerButtonTappedEvent?.subscribe({ (_) in
                if self.validateRegistrationData() {
                    var subscribeEvent = Event(type: .registerButtonTappedEvent)
                    self.event.onNext(subscribeEvent)

                    let userData = ["fullname": self.fullname.value, "username": self.username.value.lowercased(), "email": self.email.value.lowercased(), "password": self.password.value, "gender": self.gender.value] as [String: AnyObject]

                    AuthService.instance.registerUser(userData: userData, completion: { (status, error) in

                        if status {
                            self.validationRegistrationSuccess.accept(NSLocalizedString("Your account has been created.", comment: ""))
                            subscribeEvent = Event(type: .registerSuccess)
                            self.event.onNext(subscribeEvent)
                        } else {
                            self.validationRegistrationError.accept(NSLocalizedString(error!.localizedDescription, comment: ""))
                            subscribeEvent = Event(type: .registerError)
                            self.event.onNext(subscribeEvent)
                        }
                    })
                    
                } else {
                    if (!self.isFullnameValid) {
                        self.validationRegistrationError.accept(NSLocalizedString("Invalid Fullname", comment: ""))
                        let subscripeEvent = Event(type: .invalidRegisterFullname)
                        self.event.onNext(subscripeEvent)
                    }
                    if (!self.isUsernameValid) {
                        self.validationRegistrationError.accept(NSLocalizedString("Invalid Username", comment: ""))
                        let subscripeEvent = Event(type: .invalidRegisterUsername)
                        self.event.onNext(subscripeEvent)
                    }
                    if (!self.isEmailValid) {
                        self.validationRegistrationError.accept(NSLocalizedString("Invalid E-mail", comment: ""))
                        let subscripeEvent = Event(type: .invalidRegisterEmail)
                        self.event.onNext(subscripeEvent)
                    }
                    if (!self.isPasswordValid) {
                        self.validationRegistrationError.accept(NSLocalizedString("Password must contain at least 8 characters, lowercase, uppercase and special character", comment: ""))
                        let subscripeEvent = Event(type: .invalidRegisterPassword)
                        self.event.onNext(subscripeEvent)
                    }
                    if (!self.isGenderValid) {
                        self.validationRegistrationError.accept(NSLocalizedString("Please select your gender", comment: ""))
                        let subscripeEvent = Event(type: .invalidRegisterGender)
                        self.event.onNext(subscripeEvent)
                    }
                }
            }).disposed(by: disposeBag)
        }
    }
    
    func validateRegistrationData() -> Bool {
        var isValidate = true
        isFullnameValid = true
        isUsernameValid = true
        isEmailValid = true
        isPasswordValid = true
        isGenderValid = true
        
        if (fullname.value == "") {
            isFullnameValid = false
            isValidate = false
        }
        if (username.value == "") {
            isUsernameValid = false
            isValidate = false
        }
        if (email.value == "" || !self.validateEmail(email: email.value)) {
            isEmailValid = false
            isValidate = false
        }
        if (password.value == "" || !self.validatePassword(password: password.value)) {
            isPasswordValid = false
            isValidate = false
        }
        if (gender.value == "") {
            isGenderValid = false
            isValidate = false
        }
        
        return isValidate
    }
    
    private func validateEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func validatePassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-]).{8,}$"
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
}
