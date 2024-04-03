//
//  Transaction.swift
//  LedgerIO
//
//  Created by Alex Lazcano on 2024-04-03.
//

import Foundation

struct Transaction: Codable {
    let from: User
    let to: User
    let amount: Double
    let date: Date
    let description: String
}
