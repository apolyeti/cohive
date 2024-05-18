//
//  ExpensesView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/17/24.
//

import SwiftUI

struct ExpensesView: View {
    let exp : [Expense] = [
        Expense(item: "Eggs" , price: 12, message: "Big batch from costco!"),
        Expense(item: "Toilet paper", price: 15.00, message: "can we please split this"),
        Expense(item: "Avocado Oil", price: 30, message: nil)
    ]
    
    var idexp: [IdentifiableExpense] {
        exp.map { IdentifiableExpense(expense: $0) }
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            ScrollView {
                VStack {
                    ForEach(idexp) { expense in
                        ExpenseItemView(expense: expense)
                    }
                    NavigationLink {
                        AddExpenseView()
                    } label: {
                        Text("Add new expense")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ExpensesView()
    }
}
