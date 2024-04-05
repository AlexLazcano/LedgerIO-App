//
//  Transaction.swift
//  LedgerIO
//
//  Created by Alex Lazcano on 2024-04-03.
//

import Foundation

struct Transaction: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(recipient)
    }
    
    let recipient: User
    let sender: User
    let totalAmount: Double
    let amountPaidByRecepient: Double
    let date: Date
    let description: String
    
    init(from: User, to: User, totalAmount: Double, date: Date, description: String) {
            self.recipient = to
            self.sender = from
            self.totalAmount = totalAmount
            self.amountPaidByRecepient = totalAmount / 2  // Set default amountPaid to half of totalAmount
            self.date = date
            self.description = description
        }
    
    init(from: User, to: User, totalAmount: Double, date: Date, description: String, percantagePaid: Double) {
            self.recipient = to
            self.sender = from
            self.totalAmount = totalAmount
            self.amountPaidByRecepient = totalAmount * percantagePaid  // Set default amountPaid to half of totalAmount
            self.date = date
            self.description = description
        }
}
