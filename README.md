[English](./README.en.md) | [正體中文](./README.md)

# [WWCurrency](https://swiftpackageindex.com/William-Weng)

[![Swift-5.10](https://img.shields.io/badge/Swift-5.10-orange.svg)](https://developer.apple.com/swift/)
[![iOS-17.0](https://img.shields.io/badge/iOS-17.0-pink.svg?style=flat)](https://developer.apple.com/swift/)
![TAG](https://img.shields.io/github/v/tag/William-Weng/WWCurrency)
![SPM](https://img.shields.io/badge/SPM-supported-brightgreen.svg)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

ISO 4217 貨幣標準資料管理工具，提供完整的貨幣代碼、名稱與數字代碼查詢功能。

<img height="720" alt="Example" src="https://github.com/user-attachments/assets/3e803b48-4d07-4c87-8b5c-cc05bd816ac0" />

## [功能特色](https://peterpanswift.github.io/iphone-bezels/)

- ✅ 完整收錄 128 種 ISO 4217 貨幣標準
- ✅ 支援字母代碼（Alpha-3）與數字代碼（Numeric）
- ✅ 提供中文貨幣名稱
- ✅ 型別安全的 `ISO_4217` enum
- ✅ 符合 `Identifiable` 與 `CaseIterable` 協定
- ✅ 單例設計，方便全域存取

## 安裝

將此套件加入你的 Xcode 專案：

1. 在 Xcode 中選擇 **File > Add Package Dependencies**
2. 輸入套件倉庫 URL
3. 選擇版本範圍

## 使用方式

### 基本使用

```swift
import WWCurrency

// 取得單例
let currency = WWCurrency.shared

// 取得所有貨幣列表
let allCurrencies = currency.values

// 取得所有貨幣代碼（含 enum 類型）
let allCodes = currency.codes
```

### 在 SwiftUI 中使用

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

### 使用 ISO_4217 enum

```swift
// 枚舉所有貨幣
for code in ISO_4217.allCases {
    print("\(code.rawValue): \(code)")
}

// 從字串轉換
if let twd = ISO_4217(rawValue: "TWD") {
    print("找到貨幣：\(twd)")
}

// 在 WWCurrencyCode 中使用
let codes = WWCurrency.shared.codes
for code in codes {
    print("\(code.id) - \(code.code): \(code.name)")
}
```

## 資料結構

### WWCurrency

主類別，負責載入與解析 ISO 4217 資料。

| 屬性 | 類型 | 說明 |
|------|------|------|
| `shared` | `WWCurrency` | 單例實例 |
| `values` | `[WWCurrencyValue]` | 所有貨幣值陣列 |
| `codes` | `[WWCurrencyCode]` | 所有貨幣代碼陣列（含 enum） |

### WWCurrencyValue

表示單筆貨幣資料。

```swift
public struct WWCurrencyValue: Identifiable {
    public let id: Int      // 數字代碼（如 901）
    public let code: String // 字母代碼（如 "TWD"）
    public let name: String // 中文名稱（如 "新台幣"）
}
```

### WWCurrencyCode

將貨幣對應到 `ISO_4217` enum 類型。

```swift
public struct WWCurrencyCode: Identifiable {
    public let id: ISO_4217   // enum 類型
    public let code: String   // 字母代碼
    public let name: String   // 中文名稱
}
```

### ISO_4217

型別安全的貨幣代碼 enum。

```swift
enum ISO_4217: String, CaseIterable {
    case AED
    case AFN
    case ALL
    // ... 共 128 種
    case TWD
    case USD
}
```

## 參考資料

- [ISO 4217 標準](https://www.iso.org/iso-4217-currency-codes.html)
- [ISO 3166-1 國家代碼](https://www.iso.org/iso-3166-country-codes.html)
