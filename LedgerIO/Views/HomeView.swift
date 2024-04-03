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
                Text("LedgerIO")
                Spacer()
                
                
                HStack {
                    Text("Transactions")
                }
                .padding()
                .border(Color.white)
                Spacer()
                
            }.padding()
                
        }
        
    }
}

#Preview {
    HomeView()
}
