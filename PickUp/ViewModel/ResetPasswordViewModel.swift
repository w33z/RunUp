//
//  ResetPasswordViewModel.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 27/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ResetPasswordViewModel {
    
    let disposeBag = DisposeBag()
    
    let username = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    
    let validationResetError = BehaviorRelay<String>(value: "")
    let validationResetSuccess = BehaviorRelay<String>(value: "")
    var event = PublishSubject<Event>()
    
    var isUsernameValid: Bool!
    var isEmailValid: Bool!
    
    var resetButtonTappedEvent: ControlEvent<()>? {
        didSet {
            resetButtonTappedEvent?.subscribe({ (_) in
                if self.validateLoginData() {
                    var subscripeEvent = Event(type: .resetButtonTappedEvent)
                    self.event.onNext(subscripeEvent)
                    
                    AuthService.instance.resetUserPassword(username: self.username.value.lowercased(), email: self.email.value.lowercased(), completion: { (status, error) in
                        
                        if status {
                            self.validationResetSuccess.accept(NSLocalizedString("Password reset email sent", comment: ""))
                            subscripeEvent = Event(type: .resetSuccess)
                            self.event.onNext(subscripeEvent)
                        } else {
                            self.validationResetError.accept(NSLocalizedString(error!.localizedDescription, comment: ""))
                            subscripeEvent = Event(type: .resetError)
                            self.event.onNext(subscripeEvent)
                        }
                    })
                    
                } else {
                    if (!self.isUsernameValid) {
                        self.validationResetError.accept(NSLocalizedString("Invalid Username", comment: ""))
                        let subscripeEvent = Event(type: .invalidUsername)
                        self.event.onNext(subscripeEvent)
                    }
                    if (!self.isEmailValid) {
                        self.validationResetError.accept(NSLocalizedString("Invalid E-mail", comment: ""))
                        let subscripeEvent = Event(type: .invalidEmail)
                        self.event.onNext(subscripeEvent)
                    }
                }
            }).disposed(by: disposeBag)
        }
    }
    
    func validateLoginData() -> Bool {
        var isValidate = true
        isUsernameValid = true
        isEmailValid = true
        
        if (username.value == "") {
            isUsernameValid = false
            isValidate = false
        }
        
        if (email.value == "" || !self.validateEmail(email: email.value)) {
            isEmailValid = false
            isValidate = false
        }
        
        return isValidate
    }
    
    private func validateEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
