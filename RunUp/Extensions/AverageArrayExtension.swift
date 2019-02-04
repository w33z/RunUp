//
//  AverageArrayExtension.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 17/11/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation

extension Array where Element == Double {
    var average: Double {
        return isEmpty ? 0 : Double(reduce(0, +)) / Double(count)
    }
}
