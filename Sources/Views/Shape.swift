//
//  Shape.swift
//  PacificaStarted
//
//  Created by RAJA on 19/05/2015.
//  Copyright (c) 2015 RAJA. All rights reserved.
//

import UIKit

@IBDesignable class Shape: UIView {
    
    @IBInspectable var shapeColor: UIColor = UIColor.blue
    
    @IBInspectable var p1: CGPoint = CGPoint(x: 0, y: 0)
    @IBInspectable var p2: CGPoint =  CGPoint(x: 100, y: 0)
    @IBInspectable var p3: CGPoint =  CGPoint(x: 50, y: 100)
    @IBInspectable var p4: CGPoint =  CGPoint(x: 0, y: 100)
    
    override func draw(_ rect: CGRect) {
        
        let shapeBezierPath = UIBezierPath()
        
        shapeBezierPath.move(to: CGPoint(x: p1.x, y: p1.y))
        shapeBezierPath.addLine(to: CGPoint(x: p2.x, y: p2.y))
        shapeBezierPath.addLine(to: CGPoint(x: p3.x, y: p3.y))
        shapeBezierPath.addLine(to: CGPoint(x: p4.x, y: p4.y))
        shapeBezierPath.close()
        
        self.shapeColor.setFill()
        shapeBezierPath.fill()
    }
}
