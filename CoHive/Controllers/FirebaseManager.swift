//
//  FirebaseManager.swift
//  CoHive
//
//  Created by Hovhannes Muradyan on 3/28/24.
//

import Foundation
import FirebaseFirestoreInternalWrapper
import FirebaseFirestore
import FirebaseAuth
import Firebase

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

class FirestoreManager: ObservableObject {
//    @Published var hive: String = ""
//    
//    init() {
//        fetchHive(hiveRef: "hive001")
//    }
//    // thatll do it
//    func fetchHive(hiveRef: String) {
//        let db = Firestore.firestore()
//        let docRef = db.collection("hives").document(hiveRef)
//        
//        docRef.getDocument{(document, error) in
//            guard error == nil else {
//                print("error", error ?? "")
//                return
//            }
//            
//            if let document = document, document.exists {
//                let data = document.data()
//                if let data = data {
//                    print("data", data)
//                    self.hive = data["name"] as? String ?? "could not find \(hiveRef)"
//                }
//            }
//            
//        }
//    }
    
    static let shared = FirestoreManager()
    private init() {}
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
}
