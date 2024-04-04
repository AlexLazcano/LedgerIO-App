//
//  ButtonSytles.swift
//  LedgerIO
//
//  Created by Alex Lazcano on 2024-04-03.
//

import SwiftUI

struct AddDefaultButtonStyles: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.headline)
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}


