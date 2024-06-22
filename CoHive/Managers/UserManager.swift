//
//  UserManager.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/8/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift



/// Allows to connect the CoHiveUser models we have created to perform reads and writes to Firestore's Realtime Database.
/// Any logic handling CoHiveUsers should be handled here.

/* USERMANAGER START */
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
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: CoHiveUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
    
//    func createNewUser(auth: AuthDataResultModel) async throws {
//        var userData : [String : Any] = [
//            "user_id": auth.uid,
//            "date_created" : Timestamp(),
//            "email": auth.email ?? "",
//            
//        ]
//        if let email = auth.email {
//            userData["email"] = email
//        }
//        
//        if let photoUrl = auth.photoUrl {
//            userData["photo_url"] = photoUrl
//        }
//        
//        try await userDocument(userId: auth.uid).setData(userData, merge: false)
//        
//    }
    
    func getUser(userId: String) async throws -> CoHiveUser {
        try await userDocument(userId: userId).getDocument(as: CoHiveUser.self, decoder: decoder)
    }
    
    func updateUserHive(userId: String, hiveId: String) async throws {
        
//        do {
//            let hive = try await HiveManager.shared.getHive(hiveId: hiveId)
//            let data: [String: Any] = [
//                "hive": hive
//            ]
//            try await userDocument(userId: userId).updateData(data)
//            print("User \(userId) successfully bound to hive \(hiveId)")
//        } catch {
//            print(error)
//        }
        
        do {
            let hive = try await HiveManager.shared.getHive(hiveId: hiveId)
            let oldUser = try await getUser(userId: userId)
            let newUser = CoHiveUser(user: oldUser, hive: hive)
            
            try userDocument(userId: userId).setData(from: newUser, merge: false, encoder: encoder)
            print("User \(userId) successfully bound to hive \(hiveId)")
        } catch {
            print(error)
        }
    }
    
//    func getUser(userId: String) async throws -> CoHiveUser {
//        let snapshot : DocumentSnapshot = try await userDocument(userId: userId).getDocument()
//        
//        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
//            throw URLError(.badServerResponse)
//        }
//        
//        
//        let email = data["email"] as? String
//        let photoUrl = data["photo_url"] as? String
//        let dateCreated = data["date_created"] as? Date
//        
//        return CoHiveUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
//        
//    }
    
}
/* USERMANAGER START */
