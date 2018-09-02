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
        
        let username = userData["username"] as! String
        let email = userData["email"] as! String
        let password = userData["password"] as! String
        
        UserService.instance.checkUsernameExists(username: username) { (exists, errorExists) in

            if !exists {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in

                    guard let user = user?.user else {
                        completion(false, error)
                        return
                    }

                    UserService.instance.createDBUser(uid: user.uid, userData: userData.filter({ !($0.key == "password") }))
                    completion(true, nil)
                }
            } else {
                completion(false, errorExists)
            }
        }
    }
    
    func loginUser(username: String, password: String, completion: @escaping (_ status: Bool, _ error: Error?) -> ()) {

        UserService.instance.getUserEmail(username: username) { (email, err) in
            
            guard let email = email else {
                completion(false, err)
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                guard let user = user else {
                    completion(false, error)
                    return
                }
                
                //make user model -> save to realm
                
                completion(true, nil)
            }
        }
    }
    
    func resetUserPassword(username: String, email: String, completion: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        UserService.instance.getUserEmail(username: username) { (userEmail, error) in
            
            if (email == userEmail) {
                Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                    
                    if error != nil {
                        completion(false, error)
                    }
                    
                    completion(true, nil)
                }
            } else {
                
                guard let error = error else {
                    let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Entered data is incorrect"]) as Error
                    completion(false, error)
                    return
                }

                completion(false, error)
            }
        }
    }
}
