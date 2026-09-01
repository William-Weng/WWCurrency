//
//  WWCurrency.swift
//  WWCurrency
//
//  Created by William.Weng on 2026/9/1.
//

import UIKit

/// 貨幣資料管理類別，負責載入與解析 ISO 4217 貨幣標準資料
public class WWCurrency {
    
    static public let shared = WWCurrency()         // 單例實例，提供全域存取點
    
    private(set)
    public var values: [WWCurrencyValue] = []       // 所有貨幣值的陣列，包含 ID、代碼與名稱
    
    private(set)
    public var codes: [WWCurrencyCode] = []         // 所有貨幣代碼的陣列，包含 enum 類型的 ID
    
    private let resource = "/JSON/ISO_4217.json"    // JSON 資源檔案路徑
    
    /// 初始化時自動載入並解析資源檔案
    init() {
        let jsonObject = parseJsonObject(resource: resource)
        values = parseArray(jsonObject: jsonObject)
        codes = parseCodes()
    }
}

// MARK: - 私有工具
private extension WWCurrency {
    
    /// 從 Bundle 讀取並解析 JSON 資源檔案
    /// - Parameter resource: 資源檔案路徑
    /// - Returns: 解析後的 JSON 物件，若失敗則回傳 nil
    func parseJsonObject(resource: String) -> Any? {
        
        guard let jsonString = Bundle.module.readText(resource: resource),
              let jsonObject = jsonString.jsonObject()
        else {
            return nil
        }
        
        return jsonObject
    }
        
    /// 將 JSON 物件解析為貨幣值陣列
    /// - Returns: 排序後的貨幣值陣列
    func parseArray(jsonObject: Any?) -> [WWCurrencyValue] {
        
        guard let object = jsonObject as? [String: Any] else { return [] }
        
        let dict = object[WWCurrencyCode.key] as? [String: Any] ?? [:]
        var array: [WWCurrencyValue] = []
        
        for code in dict.keys.sorted() {
            
            guard let value = dict[code] as? [String: Any],
                  let id = value["ID"] as? Int,
                  let name = value["NAME"] as? String
            else {
                continue
            }
            
            let currencyValue = WWCurrencyValue(id: id, code: code, name: name)
            array.append(currencyValue)
        }
        
        return array
    }
    
    /// 將貨幣值轉換為包含 enum 類型的代碼陣列
    /// - Returns: 僅包含有效 ISO_4217 enum 的代碼陣列
    func parseCodes() -> [WWCurrencyCode] {
        
        var codes: [WWCurrencyCode] = []
        
        values.forEach { value in
            if let id = ISO_4217(rawValue: value.code) {
                codes.append(.init(id: id, code: value.code, name: value.name))
            }
        }

        return codes
    }
}
