//
//  MenuItem.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 02/09/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation

enum ImageName: String {
    case clock
    case info
    case settings
    case logout
}

struct MenuItem {
    private(set) var title: String!
    private(set) var imageName: String!
    
    init(title: String, imageName: ImageName) {
        self.title = NSLocalizedString(title, comment: "")
        self.imageName = imageName.rawValue
    }
}
