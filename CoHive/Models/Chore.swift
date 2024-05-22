//
//  Chore.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/27/24.
//

import Foundation
import SwiftData

struct Chore : Codable {
    // make sure these fields are the exact same as the ones shown on the database.

    var task: String
    var author: CoHiveUser
    var completed: Bool
    var dateCreated: Date
    
    // any updates or changes make sure to include in here as well.
    init(task: String,
         author: CoHiveUser,
         completed: Bool) 
    {
        self.task = task
        self.author = author
        self.completed = completed
        self.dateCreated = Date()
    }
}
