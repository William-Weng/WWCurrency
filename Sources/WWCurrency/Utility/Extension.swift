//
//  Extension.swift
//  WWCurrency
//
//  Created by William.Weng on 2026/9/1.
//

import UIKit

// MARK: - String (function)
extension String {
    
    /// String => Data
    /// - Parameters:
    ///   - encoding: 字元編碼
    ///   - isLossyConversion: 失真轉換
    /// - Returns: Data?
    func data(using encoding: String.Encoding = .utf8, isLossyConversion: Bool = false) -> Data? {
        let data = self.data(using: encoding, allowLossyConversion: isLossyConversion)
        return data
    }
    
    /// JSON String => JSON Object
    /// - Parameters:
    ///   - encoding: 字元編碼
    ///   - options: JSON序列化讀取方式
    /// - Returns: Any?
    func jsonObject(encoding: String.Encoding = .utf8, options: JSONSerialization.ReadingOptions = .allowFragments) -> Any? {
        
        guard let data = self.data(using: encoding),
              let jsonObject = try? JSONSerialization.jsonObject(with: data, options: options)
        else {
            return nil
        }
        
        return jsonObject
    }
}

// MARK: - Bundle (function)
extension Bundle {
    
    /// 取得外部檔案完整的URL
    /// - LiftCycle.jpeg => ./Documents/LiftCycle.jpeg
    /// - Parameter filename: 檔案名稱
    /// - Returns: URL?
    func fileUrl(with filename: String) -> URL? { return bundleURL.appendingPathComponent(filename) }
    
    /// Bundle File => String
    /// - Parameters:
    ///   - resource: 外部檔案 (scrpit.js)
    ///   - encoding: 字元編碼 (UTF8)
    /// - Returns: String?
    func readText(resource: String, encoding: String.Encoding = .utf8) -> String? {
        
        guard let fileUrl = self.fileUrl(with: "\(resource)"),
              let text = FileManager.default.readText(from: fileUrl, encoding: encoding)
        else {
            return nil
        }

        return text
    }
}

// MARK: - FileManager (function)
extension FileManager {
    
    /// 讀取檔案文字
    /// - Parameters:
    ///   - url: 文件的URL
    ///   - encoding: 編碼格式
    /// - Returns: String?
    func readText(from url: URL?, encoding: String.Encoding = .utf8) -> String? {
        
        guard let url = url,
              let readedText = try? String(contentsOf: url, encoding: encoding)
        else {
            return nil
        }
        
        return readedText
    }
}

