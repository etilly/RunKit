//
//  UIButton+Extension.swift
//  shootproof
//
//  Created by Louis DUBOSCQ on 17/02/2020.
//  Copyright © 2020 Niji. All rights reserved.
//

import UIKit

extension UIButton {

	func underline(text: String, color: UIColor) {
		let attributes = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key: Any]
		let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
		setAttributedTitle(attributedString, for: .normal)
	}
}
