//
//  UITextView+Extension.swift
//  shootproof
//
//  Created by Erwan TILLY on 07/01/2020.
//  Copyright © 2020 Niji. All rights reserved.
//

import UIKit

extension UITextView {
	
	override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

		guard let pos = closestPosition(to: point) else { return false }

		guard let range = tokenizer.rangeEnclosingPosition(pos, with: .character, inDirection: .layout(.left)) else { return false }

		let startIndex = offset(from: beginningOfDocument, to: range.start)

		return attributedText.attribute(.link, at: startIndex, effectiveRange: nil) != nil
	}
	
    func hyperLink(originalText: String, hyperLink: String, urlString: String) {
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSMakeRange(0, attributedOriginalText.length)
        
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14), range: fullRange)
        
        self.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        self.attributedText = attributedOriginalText
    }
}
