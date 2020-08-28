//
//  Int+Extension.swift
//  shootproof
//
//  Created by Erwan TILLY on 28/01/2020.
//  Copyright © 2020 Niji. All rights reserved.
//

import UIKit

extension Int {
	var toString: String { return String(self) }
	
	var degreesToRadians: CGFloat { return CGFloat(self) * CGFloat(Double.pi) / 180.0 }
	
	func localization(translation: String, translationMany: String) -> String {
		return self == 1 ? translation : translationMany
	}
}
