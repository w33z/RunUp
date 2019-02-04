//
//  User.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 18/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var id = ""
    @objc dynamic var username = ""
    @objc dynamic var fullname = ""
    @objc dynamic var email = ""
    @objc dynamic var gender = ""
    @objc dynamic var profilePicURL = ""
    @objc dynamic var height = 0
    @objc dynamic var weight = 0
}
