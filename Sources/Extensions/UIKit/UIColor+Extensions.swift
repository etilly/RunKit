//
//  ExtensionUIColor.swift
//  shootproof
//
//  Created by RAJA on 21/09/2015.
//  Copyright © 2015 Valtech. All rights reserved.
//

import UIKit

extension UIColor {
	
	struct Blue {
		static let SanteBlue = UIColor(red: 76, green: 169, blue: 238, alpha: 1)
	}
	
	convenience init(red: UInt32, green: UInt32, blue: UInt32, _alpha: UInt32) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(_alpha) / 255.0)
	}
	
	convenience init(netHex: UInt32) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff, _alpha: (netHex >> 24) & 0xff)
    }
}
