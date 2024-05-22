//
//  ChoreItemView.swift
//  CoHive
//
//  Created by Arveen Azhand on 5/22/24.
//

import SwiftUI

struct ChoreItemView: View {
    let chore: IdentifiableChore
    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    Text("\(chore.task)")
                        .bold()
                    Spacer()
                    if let email = chore.author.email {
                        Text(email)
                            .bold()
                    }
                }
            }
        }
        .backgroundStyle(Color("ButtonColor"))
        .frame(maxWidth: 300)
    }
}

//#Preview {
//    ChoreItemView()
//}
