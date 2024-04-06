//
//  LedgerIOApp.swift
//  LedgerIO
//
//  Created by Alex Lazcano on 2024-04-03.
//

import SwiftUI

@main
struct LedgerIOApp: App {
    var network = Network()
    
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(network)
        }
    }
}
