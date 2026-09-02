//
//  ContentView.swift
//  Example
//
//  Created by William.Weng on 2026/7/7.
//

import SwiftUI
import WWCurrency

struct ContentView: View {
    
    let codes = WWCurrency.shared.codes
    
    @State private var selectedCurrency: WWCurrencyCode?
    
    var body: some View {
        
        List(codes) { currency in
            Button {
                selectedCurrency = currency
            } label: {
                HStack {
                    Text(currency.id.flag)
                        .fontWeight(.semibold)
                    Text(currency.code)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(currency.name)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
