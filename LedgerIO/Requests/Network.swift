//
//  Network.swift
//  LedgerIO
//
//  Created by Alex Lazcano on 2024-04-05.
//

import Foundation
import SwiftUI

class Network: ObservableObject {
    @Published var splitTransactions: [SplitTransaction] = []
    
    func getSplitTransactions() {
        guard let url = URL(string: "http://127.0.0.1:4000/splitTransactions") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Error: Request error -", error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Unexpected response type")
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                guard let data = data else {
                    print("Error: No data received")
                    return
                }
//                if let dataString = String(data: data, encoding: .utf8) {
//                        print("Data received: \(dataString)")
//                    } else {
//                        print("Error: Unable to convert data to string")
//                    }
                
                do {
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedSplitTransactions = try decoder.decode([SplitTransaction].self, from: data)
                    
                    print("Successfully fetched split transactions:", decodedSplitTransactions)
                    DispatchQueue.main.async {
                        self.splitTransactions = decodedSplitTransactions
                    }
                } catch {
                   
                    print(error)
                    print("Error: Failed to decode JSON -", error.localizedDescription)
                }
            } else {
                print("Error: HTTP status code \(httpResponse.statusCode)")
            }
        }
        dataTask.resume()
    }
}
