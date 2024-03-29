//
//  FirebaseManager.swift
//  CoHive
//
//  Created by Hovhannes Muradyan on 3/28/24.
//

import Foundation
import Firebase

class FirestoreManager: ObservableObject {
    @Published var hive: String = ""
    
    init() {
        fetchHive()
    }
    
    func fetchHive() {
        let db = Firestore.firestore()
        let docRef = db.collection("hives").document("hive001")
        
        docRef.getDocument{(document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.hive = data["name"] as? String ?? "could not find hive001"
                }
            }
            
        }
    }
        
}
