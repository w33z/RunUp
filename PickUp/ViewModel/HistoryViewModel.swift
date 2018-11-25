//
//  HistoryViewModel.swift
//  PickUp
//
//  Created by Bartosz Pawełczyk on 25/11/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import Foundation
import RealmSwift

class HistoryViewModel {
    
    func fetchWorkouts(completion: @escaping (_ workouts: [Workout]) -> ()) {
        do {
            let realm = try Realm()
            
            let workouts = Array(realm.objects(Workout.self))
            completion(workouts)
            
        } catch {
            debugPrint(error)
        }
    }
}
