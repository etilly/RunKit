//
//  UILabel+Extension.swift
//  shootproof
//
//  Created by Erwan TILLY on 12/11/2019.
//  Copyright © 2019 Niji. All rights reserved.
//

import UIKit

extension UILabel {
	
	@IBInspectable var localizableText: String? {
		get { return text }
		set(value) {
			if let value = value {
				text = NSLocalizedString(value, comment: "")
			}
		}
	}
	
	func colorString(text: String, coloredText: String, color: UIColor) {
		colorStrings(text: text, coloredTexts: [coloredText], color: color)
	}
	
    func colorStrings(text: String, coloredTexts: [String], color: UIColor) {
        let attributedString = NSMutableAttributedString(string: text)
        for coloredText in coloredTexts {
            let range = (text as NSString).range(of: coloredText)
            attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        }
        self.attributedText = attributedString
    }
	
	func fitLines(_ numberLines: Int = 1) {
		numberOfLines = numberLines
		minimumScaleFactor = 0.5
		adjustsFontSizeToFitWidth = true
	}
	 
	func underline(text: String) {
		let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        self.attributedText = attributedText
	}
}


extension UIFont {

	func withTraits(traits:UIFontDescriptor.SymbolicTraits...) -> UIFont? {
		guard let descriptor = self.fontDescriptor
			.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) else { return nil }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func boldItalic() -> UIFont? {
		return withTraits(traits: .traitBold, .traitItalic)
    }
	
	func italic() -> UIFont? {
		return withTraits(traits: .traitItalic)
	}
}

