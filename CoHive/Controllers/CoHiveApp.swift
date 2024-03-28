//
//  CoHiveApp.swift
//  CoHive
//
//  Created by Arveen Azhand on 3/23/24.
//

import SwiftUI
import SwiftData

@main
struct CoHiveApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
    }
    
}
