//
//  DateFormatExtension.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 25/11/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation

extension Date {
    
    func getFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: self)
    }
}
