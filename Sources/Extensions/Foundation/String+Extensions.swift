//
//  ExtensionString.swift
//  shootproof
//
//  Created by RAJA on 11/09/2015.
//  Copyright © 2015 Valtech. All rights reserved.
//

import Foundation
import UIKit

class LocalizedLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        text = text?.localized()
    }
}

extension String {
	var html2String: String {
		if let data = data(using: String.Encoding.utf8),
			let string = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil).string {
			return string
		}
		return ""
	}
	
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with values: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: values)
    }
	
    func containsOnlyCharactersIn(_ matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }

    func replace(_ string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    
    func convertToHexString() -> String {
        let data = self.data(using: String.Encoding.utf8)
        return data?.reduce("") { $0 + String(format: "%02x", $1) } ?? ""
    }

    func queryParameters() -> [String: String]? {
        var paramsDict = [String: String]()
        let paramsArray = self.components(separatedBy: "&")
        
        for param in paramsArray {
            let paramParts = param.components(separatedBy: "=")
            if  let key = paramParts.first,
                let value = paramParts.last {
                    paramsDict.updateValue(value, forKey: key)
            }
        }
        return !paramsDict.isEmpty ? paramsDict : nil
    }
    
    func appendComma() -> String {
        if self.isEmpty {
            return ""
        } else {
            return self+", "
        }
    }
    
    func convertFormatOfDate(currentFormat: String, toFormat: String) -> String {
        var resultDateString = ""
        let dateFormator = DateFormatter()
        dateFormator.dateFormat = currentFormat
        if let resultDate = dateFormator.date(from: self) {
            dateFormator.dateFormat = toFormat
            resultDateString = dateFormator.string(from: resultDate)
        }
        return resultDateString
    }
	
	func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		dateFormatter.timeZone = TimeZone(secondsFromGMT: 1)
        dateFormatter.locale = Locale(identifier: "fr")
		guard let date = dateFormatter.date(from: self) else {
			preconditionFailure("Take a look to your format")
		}
		return date
	}
    
    func toFullDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
   
        return dateFormatter.date(from: self)
    }
	
	func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: Int? = nil) -> NSAttributedString {
		let attributedString = NSMutableAttributedString(string: self)
		for string in strings {
			let range = (self as NSString).range(of: string)
			attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
		}
		
		guard let characterSpacing = characterSpacing else { return attributedString }
		
		attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
		
		return attributedString
	}
	
	static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
    
    func toPhoneNumberFormat() -> String {
        var phoneNumber = self
        
        if self.count == 10 {
            phoneNumber = String(format: "%@ %@ %@ %@ %@",
            String(self[self.index(self.startIndex, offsetBy: 0)..<self.index(self.startIndex, offsetBy: 2)]),
            String(self[self.index(self.startIndex, offsetBy: 2) ..< self.index(self.startIndex, offsetBy: 4)]),
            String(self[self.index(self.startIndex, offsetBy: 4) ..< self.index(self.startIndex, offsetBy: 6)]),
            String(self[self.index(self.startIndex, offsetBy: 6) ..< self.index(self.startIndex, offsetBy: 8)]),
            String(self[self.index(self.startIndex, offsetBy: 8) ..< self.index(self.startIndex, offsetBy: 10)]))
        }
        
        return phoneNumber
    }
	
    func toSpecialPhoneNumberFormat() -> String {
        var phoneNumber = ""
        
        if self.count == 10 {
            phoneNumber = String(format: "%@ %@ %@",
            String(self[self.index(self.startIndex, offsetBy: 0)..<self.index(self.startIndex, offsetBy: 4)]),
            String(self[self.index(self.startIndex, offsetBy: 4) ..< self.index(self.startIndex, offsetBy: 7)]),
            String(self[self.index(self.startIndex, offsetBy: 7) ..< self.index(self.startIndex, offsetBy: 10)]))
        }
        
        return phoneNumber
    }
    
	var isMinor: Bool {
        var isMinor = false
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        if let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian),
			let dateOfBirth = formatter.date(from: self) {
            let age = gregorian.components([.year], from: dateOfBirth, to: today, options: [])
            if let age = age.year, age < 18 {
                // user is under 18
                isMinor = true
            }
        }
        return isMinor
    }
	
	//Converts String to Int
    func toInt() -> Int {
		guard let num = NumberFormatter().number(from: self) else { return 0 }
        return num.intValue
	}

	//Converts String to Double
	func toDouble() -> Double? {
        return NSDecimalNumber(string: self, locale: Locale.current).doubleValue
	}
    
    // Test string date is under specific age
    func isUnder(maxAge: Int) -> Bool {
        var isUnder = false
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        if let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian),
            let dateOfBirth = formatter.date(from: self) {
            let age = gregorian.components([.year], from: dateOfBirth, to: today, options: [])
            if let age = age.year, age < maxAge {
                isUnder = true
            }
        }
        return isUnder
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
