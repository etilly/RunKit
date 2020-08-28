//
//  Double+Converter.swift
//  shootproof
//
//  Created by Louis DUBOSCQ on 20/12/2019.
//  Copyright © 2019 Niji. All rights reserved.
//

import Foundation

extension Double {
    func toString() -> String {
        return String(format: "%.1f", self)
    }
	
    func toStringTwoDecimal() -> String {
        return String(format: "%.2f", self)
    }
    
    func toStringTwoDecimalAndEuroSign() -> String {
        return String(format: "%.2f€", self)
    }
    
    func toLocalString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSDecimalNumber(value: self))
    }
	
	func roundTo(places: Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}
