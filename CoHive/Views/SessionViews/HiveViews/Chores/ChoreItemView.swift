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
                        
                    Spacer()
                    if let name = chore.author.firstName {
                        Text(name)
                            
                    }
                }
            }
        }
        .backgroundStyle(Color("Button.secondary"))
        .frame(maxWidth: 300)
    }
}

