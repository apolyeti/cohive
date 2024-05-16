//
//  CoHiveUser.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/8/24.
//

import Foundation

/// Model for CoHive Users
/// Note: This is different from the User model Google uses for authentication.

/* COHIVEUSER START */
struct CoHiveUser : Codable {
    
    let userId : String
    let email : String?
    let photoUrl : String?
    let dateCreated : Date?
    let hive: Hive
    
    init(auth: AuthDataResultModel) {
        userId = auth.uid
        email = auth.email
        photoUrl = auth.photoUrl
        dateCreated = Date()
        hive = Hive(name: "", chores: [], users: [])
    }
    
    init(user: CoHiveUser, hive: Hive) {
        userId = user.userId
        email = user.email
        photoUrl = user.photoUrl
        dateCreated = user.dateCreated
        self.hive = hive
    }
    
}
/* COHIVEUSER END */
