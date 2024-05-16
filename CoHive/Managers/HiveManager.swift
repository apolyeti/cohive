//
//  HiveManager.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/15/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

/* HIVEMANAGER START */

final class HiveManager {
    
    static let shared = HiveManager() 
    private init() {}
    
    private let hiveCollection = Firestore.firestore().collection("hives")
    
    private func hiveDocument(hiveId: String) -> DocumentReference {
        hiveCollection.document(hiveId)
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
    
    func createNewHive(hive: Hive) async throws {
        try hiveDocument(hiveId: hive.hiveId).setData(from: hive, merge: false, encoder: encoder)
        try await UserManager.shared.updateUserHive(userId: hive.users[0].userId, hiveId: hive.hiveId)
    }
    
    func getHive(hiveId: String) async throws -> Hive {
        try await hiveDocument(hiveId: hiveId).getDocument(as: Hive.self, decoder: decoder)
    }
    
    func generateId()-> String {
        return hiveCollection.document().documentID
    }
    
    
}
/* HIVEMANAGER END */
