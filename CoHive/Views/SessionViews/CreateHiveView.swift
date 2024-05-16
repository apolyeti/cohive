//
//  CreateHiveView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/15/24.
//

import SwiftUI

@MainActor
final class CreateHiveViewModel : ObservableObject {
    @Published var hiveName = ""
    @Published var Users : [CoHiveUser] = []
    @Published var Chores : [Chore] = []
    
    func createNewHive() {
        
    }

}

struct CreateHiveView: View {
    @StateObject private var viewModel = CreateHiveViewModel()
    
    var body: some View {
        VStack {
            Text("Create a new Hive")
            TextField("Hive Name", text:$viewModel.hiveName)
            
            
            
        }
    }
}

#Preview {
    NavigationStack {
        CreateHiveView()
    }
}
