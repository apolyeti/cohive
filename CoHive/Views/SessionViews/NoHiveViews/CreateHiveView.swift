//
//  CreateHiveView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/21/24.
//

import SwiftUI

@MainActor
final class CreateHiveViewModel: ObservableObject {
    @Published private(set) var user: CoHiveUser? = nil
    
    @Published var hiveName: String = ""
    @Published var Users : [CoHiveUser] = []
    @Published var Chores : [Chore] = []
    
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
    
        
    
}

struct CreateHiveView: View {
    @Binding var hiveName: String
    @Binding var hiveCreated: Bool
    @State private var choreCount : Int = 0
    @State private var choreNames: [String] = []
    @StateObject private var viewModel = CreateHiveViewModel()
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                Text("Any chores to add?")
                    .font(Font.custom("Josefin Sans", size: 25))
                
                ForEach(0..<choreCount, id: \.self) { index in
                    TextField("Chore \(index + 1)", text: Binding(
                        get: {
                            if index < choreNames.count {
                                return choreNames[index]
                            } else {
                                return ""
                            }
                        },
                        set: { newValue in
                            if index < choreNames.count {
                                choreNames[index] = newValue
                            } else {
                                choreNames.append(newValue)
                            }
                        }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                }
                HStack {
                    Button {
                        Task {
                            choreCount += 1
                            choreNames.append("")
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                    }.disabled(choreCount >= 10)
                    Button {
                        Task {
                            choreCount -= 1
                            choreNames.removeLast()
                        }
                    } label: {
                        Image(systemName: "minus.circle")
                            .padding()
                    }.disabled(choreCount == 0)
                }
                Button {
                    Task {
                        hiveCreated = true
                    }
                } label: {
                    if (choreCount == 0) {
                        Text("Maybe later")
                    } else {
                        Text("Create Hive")
                    }
                }
            }
        }
    }
}

#Preview {
    
    CreateHiveView(hiveName: .constant("Sextuplets"), hiveCreated: .constant(false))
}
