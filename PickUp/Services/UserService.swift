//
//  UserService.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 18/08/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

class UserService {
    static let instance = UserService()
    
    private var _REF_USERS = ApiSettings.REF_BASE.child("users")
    private var _REF_USERNAMES = ApiSettings.REF_BASE.child("usernames")
    
    
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
    
    func getUserDetails(uid: String, completion: @escaping (_ userData: Dictionary<String, String>) -> ()) {
        
        var userData: [String: String] = [:]
        
        REF_USERS.child(uid).observe(.value) { (snapshot) in
            
            let id = snapshot.key
            
            if let dict = snapshot.value as? [String: String] {
                
                let email = dict["email"]!
                let fullname = dict["fullname"]!
                let gender = dict["gender"]!
                let username = dict["username"]!
                
                userData = ["id": id, "fullname": fullname, "username": username, "email": email, "gender": gender]
                
                completion(userData)

            }
        }
    }
    
    func createRealmUser(userData: Dictionary<String, String>) {
        
        let realm = try! Realm()
        
        let user = User()
        user.id = userData["id"]!
        user.fullname = userData["fullname"]!
        user.username = userData["username"] ?? ""
        user.email = userData["email"]!
        user.gender = userData["gender"]!
        user.profilePicURL = userData["profilePicURL"] ?? ""
            
        try! realm.write {
            realm.add(user)
        }
    }
    
    func setUserFacebookData(userData: Dictionary<String, String>) {
        
        let uid = userData["id"]!
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
        var profilePicURL = ""
        
        if let picture = fields!["picture"] as? NSDictionary {
            if let data = picture["data"] as? NSDictionary{
                if let pictureURL = data["url"] as? String {
                    profilePicURL = pictureURL
                }
            }
        }
        
        let data = ["id": id, "fullname": fullname, "email": email, "gender": gender, "profilePicURL": profilePicURL] as [String: AnyObject]
        
        return data
    }
}
