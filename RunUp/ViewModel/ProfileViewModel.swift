//
//  ProfileViewModel.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 02/12/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import RealmSwift

class ProfileViewModel {
    
    var user: User?
    
    init() {
        fetchUser()
    }
    
    func updateUser(height: Int, weight: Int) {
        do {
            let realm = try Realm()
            let user = realm.objects(User.self).first!
            
            try realm.write {
                user.height = height
                user.weight = weight
            }
            
            self.user = user
        } catch {
            debugPrint(error)
        }
    }
    
    private func fetchUser() {
        do {
            let realm = try Realm()
            let user = realm.objects(User.self).first
            
            if let user = user {
                self.user = user
            }
            
        } catch {
            debugPrint(error)
        }
    }
}
