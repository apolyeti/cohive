//
//  Chore.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/27/24.
//

import Foundation
import SwiftData

@Model
final class Chore {
    // make sure these fields are the exact same as the ones shown on the database.
    var id: Int
    var task: String
//    var author: User
    var completed: Bool
    
    // any updates or changes make sure to include in here as well.
    init(id: Int, task: String, /*author: User*/ completed: Bool) {
        self.id = id
        self.task = task
//        self.author = author
        self.completed = completed
    }
}
