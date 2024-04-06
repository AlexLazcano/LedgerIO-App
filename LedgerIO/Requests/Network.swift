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
        guard let url = URL(string: "http://localhost/4000") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print("request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200  {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    
                    do {
                        let decodedSplitTranactions = try JSONDecoder().decode([SplitTransaction].self, from: data)
                        self.splitTransactions = decodedSplitTranactions
                    }
                    
                    catch let error {
                        print("error decoding: ", error)
                    }
                }
            }
            
            
        }
        dataTask.resume()
        
    }
}
