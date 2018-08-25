//
//  AuthService.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 18/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(userData: Dictionary<String, AnyObject>, completion: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        let email = userData["username"] as! String + "@pickUp.com"
        let password = userData["password"] as! String
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            guard let user = user else {
                completion(false, error)
                return
            }
            
            UserService.instance.createDBUser(uid: user.uid, userData: userData.filter({ !($0.key == "password") }))
            completion(true, nil)
        }
    }
    
    func loginUser(username: String, password: String, completion: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        let usernameLogin = username.lowercased() + "@pickUp.com"
        
        Auth.auth().signIn(withEmail: usernameLogin, password: password) { (user, error) in
            
            guard let user = user else {
                completion(false, error)
                return
            }
            
            //make user model -> save to realm
            
            completion(true, nil)
        }

    }
}
