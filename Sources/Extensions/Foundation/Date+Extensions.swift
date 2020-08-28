//
//  ExtensionDate.swift
//  shootproof
//
//  Created by RAJA on 13/11/2015.
//  Copyright © 2015 Valtech. All rights reserved.
//

import Foundation

extension Date {
    func dateFromString(_ date: String, format: String) -> Date {
        let formatter = DateFormatter()
        let locale = Locale(identifier: "fr")
        
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = locale
        formatter.dateFormat = format
        
        return formatter.date(from: date) ?? Date()
    }
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = format
        formatter.locale = Locale.current
        
        return formatter.string(from: self)
    }
}
