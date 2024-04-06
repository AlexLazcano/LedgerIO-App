//
//  TransactionsView.swift
//  LedgerIO
//
//  Created by Alex Lazcano on 2024-04-03.
//

import SwiftUI

var user1 = User(id: "1", name: "Alex")
var user2 = User(id: "2", name: "Erik")

var transaction1 = SplitTransaction(from: user1, to: user2, totalAmount: 100, date: .now, description: "Food")

var transaction2 = SplitTransaction(from: user1, to: user2, totalAmount: 100, date: .now, description: "Subway", percantagePaid: 0.20)
var transactions: [SplitTransaction] = [
    transaction1, transaction2
]

struct SplitTransactionRow: View {
    var splitTransaction: SplitTransaction
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(splitTransaction.date, style: .date)
                    .font(.headline)
                    .bold()
                Spacer()
                
                Text("$\(splitTransaction.totalAmount, specifier: "%.2f")")
                    .font(.title)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .frame(height: 50)
            
            
            Divider()
                .background(Color.black)
            
            Grid() {
                GridRow {
                    Text(splitTransaction.recipient.name)
                        .font(.title2)
                    Text(splitTransaction.sender.name)
                        .font(.title2)
                    
                }
                GridRow() {
                    Text("$\(splitTransaction.amountPaidByRecepient, specifier: "%.2f")")
                        .font(.title3)
                    Text("$\(splitTransaction.totalAmount - splitTransaction.amountPaidByRecepient, specifier: "%.2f")")
                        .font(.title3)
                }
                
                Divider()
            }
            .border(Color.white)
            .padding(.top)
            
            HStack {
                Text(splitTransaction.description)
                    .font(.title)
                    .bold()
                
                Spacer()
                //                Text("Paid")
                Text("Pending")
                //                Image(systemName: "checkmark.circle.fill")
                //                    .font(.title)
                Image(systemName: "hourglass.circle.fill")
                    .font(.title)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .frame(height: 50)
            
            
        }
        
        .frame( alignment: .center)
        
        .background(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 2)
        )
        .padding(.horizontal)
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SplitTransactionsView: View {
    @EnvironmentObject var network: Network
    @State private var isShowingSheet = false
    
    var body: some View {
        if network.splitTransactions.isEmpty {
            ContentUnavailableView {
                Label("No Split Transactions Found", systemImage: "exclamationmark.square")
            } description: {
                Text("Create new split transaction")
            }
        }
        
        
        ScrollView {
            VStack(spacing: 15) {
                ForEach(network.splitTransactions, id: \.self) { transaction in
                    SplitTransactionRow(splitTransaction: transaction)
                }
            }
            
        }
        Button(action: {
            isShowingSheet.toggle()
        }) {
            HStack {
                Text("Add Transaction")
                Image(systemName: "plus.circle")
            }
            .modifier(AddDefaultButtonStyles())
            
        }
        .sheet(isPresented: $isShowingSheet){
            AddTransactionForm(isShowing: $isShowingSheet)
        }
    }
}

#Preview {
    SplitTransactionsView()
        .environmentObject(Network())
}
