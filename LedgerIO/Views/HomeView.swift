//
//  HomeView.swift
//  LedgerIO
//
//  Created by Alex Lazcano on 2024-04-03.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink(destination: SplitTransactionsView()) {
                    Text("Transactions")
                        .modifier(AddDefaultButtonStyles())
                }
                .navigationTitle("LedgerIO")
                
                NavigationLink(destination: FriendsView()) {
                    Text("Friends")
                        .modifier(AddDefaultButtonStyles())
                }
                Button(action: {
                    
                }, label: {
                    Text("Add Transaction")
                        .modifier(AddDefaultButtonStyles())
                })
                Spacer()
            }
            .padding()
            
        }
    }
}

#Preview {
    HomeView()
}
