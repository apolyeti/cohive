//
//  AppDelegate.swift
//  CoHive
//
//  Created by Arveen Azhand on 4/1/24.
//

import UIKit
import FirebaseCore
import GoogleSignIn

/* APP DELEGATE START */
class AppDelegate: UIResponder, UIApplicationDelegate {
    /// We start our delegate here for Firestore to bind to our application.
    var window: UIWindow?
    
    /* FIREBASE CONFIGURATION START */
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
    /* FIREBASE CONFIGURATION END */
    
    /* GOOGLE ID SIGN IN CONFIGURATION START */
    func application(_ app: UIApplication,
                         open url: URL,
                         options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
          return GIDSignIn.sharedInstance.handle(url)
    }
    /* GOOGLE ID SIGN IN CONFIGURATION START */
    
}
/* APP DELEGATE END */
