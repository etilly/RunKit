//
//  Array+Extensions.swift
//  Pods
//
//  Created by Erwan TILLY on 27/08/2020.
//

import UIKit

extension Array {
    public mutating func appendAll(_ list: [Element]?) {
        if let list = list {
            self.append(contentsOf: list)
        }
    }
}

extension Array where Element == UILabel {
    /**
     Make the  labels adjust their font to fit width and adjust their font by taking the smallest font of them all
     */
    public func adjustFontSizesToMatchSmallest() {
        self.forEach {
            $0.adjustsFontSizeToFitWidth = true
            $0.layoutIfNeeded()
        }
        
        guard let minFont = (self.compactMap { computeFontActualSize(for: $0) }.min()) else { return }
        
        self.forEach { $0.font = $0.font.withSize(minFont) }
    }
    
    /**
        Computes the actual font size displayed by the label
    */
    private func computeFontActualSize(for label: UILabel) -> CGFloat? {
        guard let text = label.text, let fontAttribute = label.font else { return nil }
        
        // set label minimum scale factor, required to get the actualScaleFactor afterwards
        label.minimumScaleFactor = 0.1
        
        // set up attributed string to simulate drawing with text
        let attributes = [NSAttributedString.Key.font: fontAttribute]
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        
        // simulate drawing
        let context = NSStringDrawingContext()
        context.minimumScaleFactor = label.minimumScaleFactor
        attributedString.boundingRect(with: label.bounds.size, options: .usesLineFragmentOrigin, context: context)
        
        return label.font.pointSize * context.actualScaleFactor
    }
}
