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
    var Users: [User]
    
    // any updates or changes make sure to include in here as well.
    init(id: Int, name: String, Users: [User]) {
        self.id = id
        self.name = name
        self.Users = Users
    }
    
}
