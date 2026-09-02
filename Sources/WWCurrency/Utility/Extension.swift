//
//  Extension.swift
//  WWCurrency
//
//  Created by William.Weng on 2026/9/1.
//

import UIKit

// MARK: - String
private extension String {
    
    /// 🇦- A的差值（僅在首次存取時實際計算一次，隨後直接複用）
    static let flagBase: UInt32 = {
        let regionalIndicatorA = "🇦".unicodeScalars.first!.value   // 0x1F1E6
        let asciiA = "A".unicodeScalars.first!.value                // 0x41
        return regionalIndicatorA - asciiA                          // 0x1F1A5
    }()
}

// MARK: - String
extension String {
    
    /// 將二位字母國家代碼轉換為國旗 Emoji (ISO 3166-1)
    var flag: String {
        
        guard count == 2 else { return self }
        
        let base: UInt32 = String.flagBase
        
        var result = ""
        for char in uppercased() {
            if let scalar = Unicode.Scalar(UInt32(char.asciiValue!) + base) {
                result.append(String(scalar))
            }
        }
        
        return result
    }
}

// MARK: - String (function)
extension String {
    
    /// JSON String => JSON Object
    /// - Parameters:
    ///   - encoding: 字元編碼
    ///   - options: JSON序列化讀取方式
    /// - Returns: Any?
    func jsonObject(encoding: String.Encoding = .utf8, options: JSONSerialization.ReadingOptions = .allowFragments) -> Any? {
        
        guard let data = data(using: encoding),
              let jsonObject = try? JSONSerialization.jsonObject(with: data, options: options)
        else {
            return nil
        }
        
        return jsonObject
    }
}

// MARK: - String (function)
private extension String {
    
    /// String => Data
    /// - Parameters:
    ///   - encoding: 字元編碼
    ///   - isLossyConversion: 失真轉換
    /// - Returns: Data?
    func data(using encoding: String.Encoding = .utf8, isLossyConversion: Bool = false) -> Data? {
        let data = self.data(using: encoding, allowLossyConversion: isLossyConversion)
        return data
    }
}

// MARK: - Bundle (function)
extension Bundle {
    
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

// MARK: - Bundle (function)
private extension Bundle {
    
    /// 取得外部檔案完整的URL
    /// - LiftCycle.jpeg => ./Documents/LiftCycle.jpeg
    /// - Parameter filename: 檔案名稱
    /// - Returns: URL?
    func fileUrl(with filename: String) -> URL? { return bundleURL.appendingPathComponent(filename) }
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

