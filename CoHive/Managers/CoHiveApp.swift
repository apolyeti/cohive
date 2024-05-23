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


/* MAIN COHIVE START */
@main
struct CoHiveApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    /* SHOW ROOT VIEW START */
    var body: some Scene {
        let customFont : Font = Font.custom("Josefin Sans", size: 20)
        WindowGroup {
            NavigationStack {
                RootView()
                    .font(customFont)
            }
        }
        
    }
    /* SHOW ROOT VIEW END */
}
/* MAIN COHIVE END */

