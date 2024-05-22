//
//  IdentifiableChore.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/22/24.
//

import Foundation

struct IdentifiableChore: Identifiable {
    var id: UUID
    
    var task: String
    var author: CoHiveUser
    var completed: Bool
    
    init(chore: Chore) {
        self.id = UUID()
        self.task = chore.task
        self.author = chore.author
        self.completed = chore.completed
    }
}
