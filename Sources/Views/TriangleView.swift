//
//  TriangleView.swift
//  shootproof
//
//  Created by Guillaume Elloy on 06/10/15.
//  Copyright © 2015 Valtech. All rights reserved.
//

import UIKit

class TriangleView: UIView {
    let viewID: String = "TriangleView"
    var isOpen = false
    
     var color = UIColor(netHex: 0xff425464).cgColor
    
     init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.color = color.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.color)
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: frame.width, y: 0))
        context?.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        context?.addLine(to: CGPoint(x: 0, y: 0))
        context?.fillPath()
    }
    
    internal static func rotate(_ view: UIView, value: Int) {
        UIView.animate(withDuration: 0.25, animations: {
            view.transform = CGAffineTransform(rotationAngle: value.degreesToRadians)
            }, completion: { _ in
                view.transform = CGAffineTransform(rotationAngle: value.degreesToRadians)
        })
    }
    
    internal static func makeTriangle(_ frame: CGRect, opColor: UIColor?) -> UIImage {
        let triangle: TriangleView
        if let color = opColor {
            triangle = TriangleView(frame: frame, color: color)
        } else {
            triangle = TriangleView(frame: frame)
        }
        UIGraphicsBeginImageContext(triangle.bounds.size)
		guard let currentContext = UIGraphicsGetCurrentContext() else { return UIImage() }
		triangle.layer.render(in: currentContext)
        let triangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return triangleImage ?? UIImage()
    }
}
