//
//  HiveCreationRedirectView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/15/24.
//

import SwiftUI

/// This solely exists as a method of redirecting the user to the hive they have created when creating a new hive.

struct HiveCreationRedirectView: View {
    @State private var hiveCreated: Bool = false
    @State private var hiveNamed: Bool = false
    
    var body: some View {
        ZStack {
            if !hiveCreated {
                NavigationStack {
                    NameNewHiveView(hiveCreated: $hiveCreated, hiveNamed: $hiveNamed)
                }
            } else {
                NavigationStack {
                    HiveView()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HiveCreationRedirectView()
    }
}
