//
//  FormattedTimeIntervalExtension.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 14/11/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    func getFormattedString() -> String {
        
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
