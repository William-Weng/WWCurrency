[English](./README.en.md) | [正體中文](./README.md)

# [WWCurrency](https://swiftpackageindex.com/William-Weng)

[![Swift-5.10](https://img.shields.io/badge/Swift-5.10-orange.svg)](https://developer.apple.com/swift/)
[![iOS-17.0](https://img.shields.io/badge/iOS-17.0-pink.svg?style=flat)](https://developer.apple.com/swift/)
![TAG](https://img.shields.io/github/v/tag/William-Weng/WWCurrency)
![SPM](https://img.shields.io/badge/SPM-supported-brightgreen.svg)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

ISO 4217 currency standard data management tool, providing complete currency codes, names, and numeric code lookup functionality.

## Features

- ✅ Complete coverage of 128 ISO 4217 currencies
- ✅ Support for Alpha-3 and Numeric codes
- ✅ Chinese currency names included
- ✅ Type-safe `ISO_4217` enum
- ✅ Conforms to `Identifiable` and `CaseIterable` protocols
- ✅ Singleton design for easy global access

## Installation

Add this package to your Xcode project:

1. In Xcode, select **File > Add Package Dependencies**
2. Enter the package repository URL
3. Select version range

## Usage

### Basic Usage

```swift
import WWCurrency

// Get singleton instance
let currency = WWCurrency.shared

// Get all currencies
let allCurrencies = currency.values

// Get all currency codes (with enum type)
let allCodes = currency.codes
```

### Using in SwiftUI

```swift
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
```

### Using ISO_4217 Enum

```swift
// Iterate through all currencies
for code in ISO_4217.allCases {
    print("\(code.rawValue): \(code)")
}

// Convert from string
if let twd = ISO_4217(rawValue: "TWD") {
    print("Found currency: \(twd)")
}

// Use with WWCurrencyCode
let codes = WWCurrency.shared.codes
for code in codes {
    print("\(code.id) - \(code.code): \(code.name)")
}
```

## Data Structures

### WWCurrency

Main class responsible for loading and parsing ISO 4217 data.

| Property | Type | Description |
|----------|------|-------------|
| `shared` | `WWCurrency` | Singleton instance |
| `values` | `[WWCurrencyValue]` | Array of all currency values |
| `codes` | `[WWCurrencyCode]` | Array of all currency codes (with enum) |

### WWCurrencyValue

Represents a single currency entry.

```swift
public struct WWCurrencyValue: Identifiable {
    public let id: Int      // Numeric code (e.g., 901)
    public let code: String // Alpha-3 code (e.g., "TWD")
    public let name: String // Chinese name (e.g., "新台幣")
}
```

### WWCurrencyCode

Maps currency to `ISO_4217` enum type.

```swift
public struct WWCurrencyCode: Identifiable {
    public let id: ISO_4217   // Enum type
    public let code: String   // Alpha-3 code
    public let name: String   // Chinese name
}
```

### ISO_4217

Type-safe currency code enum.

```swift
enum ISO_4217: String, CaseIterable {
    case AED
    case AFN
    case ALL
    // ... 128 total
    case TWD
    case USD
}
```

## References

- [ISO 4217 Standard](https://www.iso.org/iso-4217-currency-codes.html)
- [ISO 3166-1 Country Codes](https://www.iso.org/iso-3166-country-codes.html)
