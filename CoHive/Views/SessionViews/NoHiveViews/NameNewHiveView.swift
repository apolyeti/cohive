//
//  CreateHiveView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/15/24.
//

import SwiftUI

@MainActor
final class NameNewHiveViewModel : ObservableObject {
    @Published private(set) var user: CoHiveUser? = nil
    
    @Published var hiveName = ""
    @Published var Users : [CoHiveUser] = []
//    @Published var Chores : [Chore] = []
    
    func loadCurrentUser() async throws {
        let authDataResult = try FirestoreManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func createNewHive() async throws {
        guard !hiveName.isEmpty else {
            print("Hive name is empty")
            return
        }
        
        try await loadCurrentUser()
        
        guard let currentUser = user else {
            print("Current user not found")
            return
        }
        
        
        
        let hive = Hive(name: hiveName, chores: [], users: [currentUser])
        
        try await HiveManager.shared.createNewHive(hive: hive)
    }
    
    func nameIsEmpty() -> Bool {
        return hiveName.isEmpty
    }

}

struct NameNewHiveView: View {
    @StateObject private var viewModel = NameNewHiveViewModel()
    @Binding var hiveCreated: Bool
    @Binding var hiveNamed: Bool
    
//    @State var name: String
    
    var body: some View {
        if !hiveNamed {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack {
                    Text("What would you like to name your hive?")
                        .font(.headline)
                    TextField("Hive Name",text:$viewModel.hiveName)
                        .frame(width: 250, height: 30)
                        .padding()
                        .background(Color("ButtonColor"))
                        .cornerRadius(5)

                    
                    Button {
                        Task {
                            if !viewModel.hiveName.isEmpty {
                                hiveNamed = true
                            }
                        }
                        
                    } label: {
                        Text("Continue setup")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height:55)
                            .background(Color("AccentColor"))
                            .cornerRadius(10)
                    }.disabled(viewModel.hiveName.isEmpty)
                }
            }
        } else {
            CreateHiveView(hiveName: $viewModel.hiveName, hiveCreated: $hiveCreated)
        }
        
    }
}

#Preview {
    NavigationStack {
        NameNewHiveView(hiveCreated: .constant(false), hiveNamed: .constant(false))
    }
}
