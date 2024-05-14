//
//  CoHiveUser.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/8/24.
//

import Foundation

struct CoHiveUser : Codable {
    
    let userId : String
    let email : String?
    let photoUrl : String?
    let dateCreated : Date?
    
    init(auth: AuthDataResultModel) {
        userId = auth.uid
        email = auth.email
        photoUrl = auth.photoUrl
        dateCreated = Date()
    }
    
}
