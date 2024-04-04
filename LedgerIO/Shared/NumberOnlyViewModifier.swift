//
//  NumberOnlyViewModifier.swift
//  LedgerIO
//
//  Created by Alex Lazcano on 2024-04-03.
//

import Foundation
import Combine
import SwiftUI

struct NumberOnlyViewModifier: ViewModifier {
    @Binding var text: String
    var includeDecimal: Bool
    
    func body(content: Content)  -> some View {
        content
            .keyboardType(includeDecimal ? .decimalPad : .numberPad)
            .onReceive(Just(text)) { newValue in
                var numbers = "0123456789"
                let decimalSeparator: String = Locale.current.decimalSeparator ?? "."
                if includeDecimal {
                    numbers += decimalSeparator
                }
                
                if newValue.components(separatedBy: decimalSeparator).count - 1 > 1 {
                    let filtered  = newValue
                    self.text = String(filtered.dropLast())
                } else {
                    let filtered = newValue.filter {
                        numbers.contains($0)
                        
                    }
                    if filtered != newValue {
                        self.text = filtered
                    }
                    
                }
                
                
            }
    }
}

extension View {
    func numbersOnly(_ text: Binding<String>, includeDecimal: Bool = false) -> some View {
        self.modifier(NumberOnlyViewModifier(text: text, includeDecimal: includeDecimal))
    }
}
