//
//  Model.swift
//  WWCurrency
//
//  Created by William.Weng on 2026/9/1.
//

import Foundation

/// 貨幣值結構，表示單筆貨幣資料（數字 ID、代碼、名稱）
public struct WWCurrencyValue: Identifiable {
    
    public let id: Int          // 數字代碼（ISO 4217 Numeric Code），符合 Identifiable 協定
    public let code: String     // 字母代碼（ISO 4217 Alpha-3 Code），如 "TWD"、"USD"
    public let name: String     // 貨幣中文名稱，如 "新台幣"、"美元"
}

/// 貨幣代碼結構，將字母代碼對應到 ISO_4217 enum 類型
public struct WWCurrencyCode: Identifiable {
    
    static let key = "ISO_4217" // JSON 中 ISO_4217 貨幣字典的鍵值
    
    public let id: ISO_4217     // ISO 4217 enum 類型的 ID，符合 Identifiable 協定
    public let code: String     // 字母代碼（ISO 4217 Alpha-3 Code），如 "TWD"、"USD"
    public let name: String     // 貨幣中文名稱，如 "新台幣"、"美元"
}
