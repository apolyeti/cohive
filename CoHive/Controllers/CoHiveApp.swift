//
//  CoHiveApp.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/23/24.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore
import GoogleSignIn


@main
struct CoHiveApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var sharedModelContainer: ModelContainer = {
        // (Hovhannes) temporarily changed referenced schema field to User to prevent error
        // (Arveen) temporarily cleared Schemas due to repetitive references to User (both our code and Google's)
        let schema = Schema([
            //            User.self,
            //            Hive.self,
            //            Chore.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    
    
    var body: some Scene {
        let customFont : Font = Font.custom("Josefin Sans", size: 20)
        WindowGroup {
            NavigationStack {
                RootView()
                    .font(customFont)
            }
            .modelContainer(sharedModelContainer)
            //        .environmentObject(firestoreManager)
        }
        
    }
}

