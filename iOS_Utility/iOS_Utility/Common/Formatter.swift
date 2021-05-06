//
//  Formatter.swift
//  iOS_Utility
//
//  Created by JS_Ju on 2021/05/06.
//  Copyright © 2021 Joongsun Joo. All rights reserved.
//

import Foundation

class OnlyPasitiveIntegerNumberFormatter: NumberFormatter {
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        if partialString.isEmpty {
            return true
        }
        
        if let number = Int(partialString), number > 0 {
            return true
        }
        
        return false
    }
}

class AppDateFormatter {
    static func bringBasicFormat() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter
    }
    
    static func bringCurrentTimeZoneFormat(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale.current
        formatter.dateFormat = format
        
        return formatter
    }
    
    static func bringKoreaFormat(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "KST")
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = format
        
        return formatter
    }
}

