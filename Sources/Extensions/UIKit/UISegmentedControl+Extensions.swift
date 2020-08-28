//
//  ExtensionSegmentedControl.swift
//  shootproof
//
//  Created by RAJA on 12/10/2015.
//  Copyright © 2015 Valtech. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    func makeMultiline(_ numberOfLines: Int) {
        for segment in self.subviews {
            let labels = segment.subviews.filter { $0 is UILabel }
            if let labels = labels as? [UILabel] {
                _ = labels.map { $0.numberOfLines = numberOfLines }
            }
        }
    }
}
