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
    
    private var _REF_BASE = Settings.DB_BASE
    private var _REF_USERS = Settings.DB_BASE.child("users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, AnyObject>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
}
