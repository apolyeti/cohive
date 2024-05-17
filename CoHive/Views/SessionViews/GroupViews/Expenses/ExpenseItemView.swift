//
//  ExpenseItemView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/17/24.
//

import SwiftUI

struct ExpenseItemView: View {
    let expense: Expense
    var body: some View {
        GroupBox("Content") {
            Text("Test content at the moment")
        }
    }
}

#Preview {
    ExpenseItemView()
}
