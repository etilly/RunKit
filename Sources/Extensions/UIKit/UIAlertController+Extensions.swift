//
//  ExtensionUIAlertController.swift
//  shootproof
//
//  Created by Erwan TILLY on 10/10/2019.
//  Copyright © 2019 Niji. All rights reserved.
//

import UIKit

extension UIAlertController {
	
	func setMessageBoldString(boldTxt: String) {
		
		guard let title = self.message else {
			return
		}
		
        let attributedString = NSMutableAttributedString(string: title)
		
		var boldedRange = NSRange()
		if let rangeTitle = title.range(of: boldTxt) {
			boldedRange = NSRange(rangeTitle, in: title)
		}
		
        attributedString.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)], range: boldedRange)
        self.setValue(attributedString, forKey: "attributedMessage")
    }
}
