//
//  CoHiveApp.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/23/24.
//

import SwiftUI
import SwiftData
import Firebase
import GoogleSignIn


@main
struct CoHiveApp: App {
//    @StateObject var firestoreManager = FirestoreManager()
    
    
//    init() {
//        FirebaseApp.configure()
//    }
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var sharedModelContainer: ModelContainer = {
        // (Hovhannes) temporarily changed referenced schema field to User to prevent error
        let schema = Schema([
            User.self,
            Hive.self,
            Chore.self
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
            SignedOutView()
                .font(customFont)
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(firestoreManager)
    }
    
}


//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//
//        return true
//    }
//    
//    func application(_ app: UIApplication,
//                     open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
//      return GIDSignIn.sharedInstance.handle(url)
//    }
//    
//    
//}
