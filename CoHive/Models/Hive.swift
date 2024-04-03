//
//  Hive.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/27/24.
//

import Foundation
import SwiftData

@Model
final class Hive {
    // make sure these fields are the exact same as the ones shown on the database.
    var id: Int
    var name: String
//    var users: [User]
    var chores: [Chore]
    
    // any updates or changes make sure to include in here as well.
    init(id: Int, name: String, /*users: [User],*/ chores: [Chore]) {
        self.id = id
        self.name = name
//        self.users = users
        self.chores = chores
    }

}
