//
//  ExpenseItemView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/17/24.
//

import SwiftUI

struct ExpenseItemView: View {
    let expense: IdentifiableExpense
    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    Text("\(expense.item)")
                        .bold()
                    Spacer()
                    Text("$\(expense.price, specifier: "%.2f")")
                        .bold()
                }
                if let message = expense.message {
                    HStack {
                        Text(message)
                            .italic()
                        Spacer()
                    }
                }
            }
        }
        .backgroundStyle(Color("ButtonColor"))
        .frame(maxWidth: 300)
    }
}

//#Preview {
//    let expense = Expense(item: "Eggs", price: 11.99, message: "split 6 ways please pay up")
//    let idexpense = IdentifiableExpense(expense: expense)
//    
//    ExpenseItemView(expense: idexpense)
//}
