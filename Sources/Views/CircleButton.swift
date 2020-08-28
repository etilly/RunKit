//
//  CircleButton.swift
//  shootproof
//
//  Created by RAJA on 22/09/2015.
//  Copyright © 2015 Valtech. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton, CAAnimationDelegate {
    
     var circleLayer: CAShapeLayer = CAShapeLayer()
     var iconLayer: CALayer = CALayer()
    
    // ---------------- INSPECTABLE PROPERTIES ----------------
    
    @IBInspectable var icon: UIImage?
    @IBInspectable var iconScale: Double = 1.0
    @IBInspectable var circleColor: UIColor = UIColor(netHex: 0x36CBD3)
    @IBInspectable var accentColor: UIColor = UIColor.white
    @IBInspectable var leftTopInsets: CGPoint = CGPoint.zero
    @IBInspectable var rightBottomInsets: CGPoint = CGPoint.zero
    
    @IBInspectable var gradientColor1: UIColor = UIColor(netHex: 0xff065862)
    @IBInspectable var gradientColor2: UIColor = UIColor(netHex: 0xff36cbd3)
    
    // ---------------- LAYERS SETTERS ----------------
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.initLayersFrames()
        
        self.initCircleLayer()
        self.initIconLayer()
    }
    
     func initLayersFrames() {
        self.setCircleLayerFrame()
        self.setIconLayerFrame()
        
        if self.layer.sublayers == nil {
            let gradientLayer = CAGradientLayer()
            
            gradientLayer.frame = self.circleLayer.bounds
            //DARK TITLE
            let color1 = gradientColor1.cgColor
            //LIGHT
            let color2 = gradientColor2.cgColor

            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.colors = [color2, color1]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.mask = self.circleLayer
            gradientLayer.addSublayer(self.iconLayer)
            self.layer.addSublayer(gradientLayer)
        }
    }
    
     func setCircleLayerFrame() {
        self.circleLayer.position = CGPoint(x: (self.layer.bounds.width - self.rightBottomInsets.x) / 2.0,
											y: (self.layer.bounds.height - self.rightBottomInsets.y) / 2.0)
        self.circleLayer.bounds = CGRect(x: 0,
										 y: 0,
										 width: self.layer.bounds.width - self.leftTopInsets.x - self.rightBottomInsets.x,
										 height: self.layer.bounds.height - self.leftTopInsets.y - self.rightBottomInsets.y)
    }
    
     func setIconLayerFrame() {
        self.iconLayer.position = CGPoint(x: self.circleLayer.bounds.width / 2.0,
										  y: self.circleLayer.bounds.height / 2.0)
        self.iconLayer.bounds = CGRect(x: 0,
									   y: 0,
									   width: self.circleLayer.bounds.width,
									   height: self.circleLayer.bounds.height)
    }

     func initCircleLayer() {

        self.circleLayer.backgroundColor = UIColor.clear.cgColor
        self.circleLayer.fillColor = self.circleColor.cgColor
        let radius = min(self.circleLayer.bounds.width, self.circleLayer.bounds.height) / 2.0
        let center = CGPoint(x: self.circleLayer.bounds.width/2.0, y: self.circleLayer.bounds.height / 2.0)
        self.circleLayer.path = UIBezierPath(arcCenter: center,
											 radius: radius,
											 startAngle: 0,
											 endAngle: CGFloat(2 * Double.pi),
											 clockwise: true).cgPath

    }

     func initIconLayer() {
        self.iconLayer.backgroundColor = UIColor.clear.cgColor
        self.setIconImage()
        self.iconLayer.contentsGravity = CALayerContentsGravity.center
        self.setIconScale()
    }
    
     func setIconImage() {
        if let iconImage = self.icon {
            self.iconLayer.contents = iconImage.exColorizeWithColor(self.accentColor).cgImage
        }
    }
    
     func setIconScale() {
        self.iconLayer.contentsScale = (1 / CGFloat(self.iconScale)) * UIScreen.main.scale
    }
    
     func animateCircleLayerOpacityWithKey(_ key: String) {
        var from: CGFloat = 1
        var to: CGFloat = 0.5
        
        if key == self.K_END_ANIMATION {
            from = 0.5
            to = 1
        }
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = from
        animation.toValue = to
        animation.duration = 0.10
        animation.delegate = self
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        self.isAnimating = true
        animation.setValue(key, forKey: key)
        self.circleLayer.add(animation, forKey: key)
    }
    
     let K_BEGIN_ANIMATION: String = "beginBackgroundAnimation"
     let K_END_ANIMATION: String = "endBackgroundAnimation"
    
     var isTouching = true
     var isAnimating = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouching = true
        self.animateCircleLayerOpacityWithKey(self.K_BEGIN_ANIMATION)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouching = false
        if !self.isAnimating {
            self.animateCircleLayerOpacityWithKey(self.K_END_ANIMATION)
        }
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouching = false
        if !self.isAnimating {
            self.animateCircleLayerOpacityWithKey(self.K_END_ANIMATION)
        }
        super.touchesCancelled(touches, with: event)
    }
    
     func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.isAnimating = false
        if let animationKey = anim.value(forKey: self.K_BEGIN_ANIMATION) as? String {
            if !self.isTouching && animationKey == self.K_BEGIN_ANIMATION {
                self.animateCircleLayerOpacityWithKey(self.K_END_ANIMATION)
            }
        }
    }
}
