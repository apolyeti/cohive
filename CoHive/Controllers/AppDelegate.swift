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
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
    
    func application(_ app: UIApplication,
                         open url: URL,
                         options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
          return GIDSignIn.sharedInstance.handle(url)
    }
    
}
/* APP DELEGATE END */
