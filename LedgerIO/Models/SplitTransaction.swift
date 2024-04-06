//
//  Transaction.swift
//  LedgerIO
//
//  Created by Alex Lazcano on 2024-04-03.
//

import Foundation

struct SplitTransaction: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(recipient)
    }
    
    let recipient: User
    let sender: User
    let total: Double
    let splitAmount: Double
    let date: Date
    let description: String
    
    
    init(from: User, to: User, totalAmount: Double, date: Date, description: String) {
            self.recipient = to
            self.sender = from
            self.total = totalAmount
            self.splitAmount = totalAmount / 2  // Set default amountPaid to half of totalAmount
            self.date = date
            self.description = description
        }
    
    init(from: User, to: User, totalAmount: Double, date: Date, description: String, percantagePaid: Double) {
            self.recipient = to
            self.sender = from
            self.total = totalAmount
            self.splitAmount = totalAmount * percantagePaid  // Set default amountPaid to half of totalAmount
            self.date = date
            self.description = description
        }
}
