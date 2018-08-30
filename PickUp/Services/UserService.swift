//
//  UserService.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 18/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import Firebase

class UserService {
    static let instance = UserService()
    
    private var _REF_USERS = Settings.REF_BASE.child("users")
    private var _REF_USERNAMES = Settings.REF_BASE.child("usernames")
    
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_USERNAMES: DatabaseReference {
        return _REF_USERNAMES
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, AnyObject>) {
        REF_USERS.child(uid).updateChildValues(userData)
        
        let username = userData["username"] as! String
        let email = userData["email"] as! String
        
        REF_USERNAMES.child(username).updateChildValues(["email": email, "uid": uid])
    }
    
    func checkUsernameExists(username: String, completion: @escaping (Bool, Error?) -> ()) {
     
        REF_USERNAMES.observe(.value) { (snapshot) in
            
            guard let dictionary = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            let error = NSError(domain: "", code: 409, userInfo: [NSLocalizedDescriptionKey: "Username already exists! Please try another one"]) as Error
            
            for usern in dictionary {
                if (usern.key == username) {
                    completion(true,error)
                    break
                }
            }
            completion(false, nil)
        }
    }
    
    func getUserEmail(username: String, completion: @escaping (_ email: String?,_ error: Error?) -> ()) {
        
        let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "The user you entered does not exist"]) as Error

        REF_USERNAMES.child(username).observeSingleEvent(of: .value) { (snapshot) in

            if (snapshot.value is NSNull) {
                completion(nil, error)
            } else {
                let dictionary = snapshot.value! as! Dictionary<String, String>
                let email = (dictionary["email"] as String?)!
                completion(email,nil)
            }
        }
    }
    
    func setUserFacebookData(userData: Dictionary<String, AnyObject>) {
        
        let uid = userData["id"] as! String
        var uData = userData.filter({ !($0.key == "id") })
        uData = userData.filter({ !($0.key == "pictureURL") })
        REF_USERS.child(uid).updateChildValues(uData)
    }
    
    func parseUserFacebookData(result: Any?) -> Dictionary<String, AnyObject> {
        let fields = result as? [String: AnyObject]
        let id = fields!["id"] as? String
        let fullname = fields!["name"] as? String
        let email = fields!["email"] as? String
        let gender = fields!["gender"] as? String
        
        let picture = fields!["picture"] as? [String: AnyObject]
        let data = picture!["data"] as? [String: AnyObject]
        let pictureURL = data!["url"] as! String
        
        return ["id": id, "fullname": fullname, "email": email, "gender": gender, "pictureURL": pictureURL] as [String: AnyObject]
    }
}
