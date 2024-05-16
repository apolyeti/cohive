//
//  Hive.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/27/24.
//

import Foundation
import SwiftData


struct Hive : Codable {
    // make sure these fields are the exact same as the ones shown on the database.
    var hiveId: String
    var name: String
//    var users: [User]
    var chores: [Chore]
    var users: [CoHiveUser]
    
    // any updates or changes make sure to include in here as well.
    init(id: String,
         name: String,
         chores: [Chore],
         users: [CoHiveUser])
    {
        self.hiveId = id
        self.name = name
        self.chores = chores
        self.users = users
    }
    

}
