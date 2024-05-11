//
//  UserManager.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/8/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    func createNewUser(user: CoHiveUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        var userData : [String : Any] = [
            "user_id": auth.uid,
            "date_created" : Timestamp(),
            "email": auth.email ?? "",
            
        ]
        if let email = auth.email {
            userData["email"] = email
        }
        
        if let photoUrl = auth.photoUrl {
            userData["photo_url"] = photoUrl
        }
        
        try await userDocument(userId: auth.uid).setData(userData, merge: false)
        
    }
    
    func getUser(userId: String) async throws -> CoHiveUser {
        let snapshot : DocumentSnapshot = try await userDocument(userId: userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        
        let email = data["email"] as? String
        let photoUrl = data["photo_url"] as? String
        let dateCreated = data["date_created"] as? Date
        
        return CoHiveUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
        
    }
    
}
