//
//  UIImage+Extension.swift
//  shootproof
//
//  Created by Guillaume Elloy on 24/07/15.
//  Copyright © 2015 Valtech. All rights reserved.
//

import UIKit

extension UIImage {
	
    func color(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        var newImage: UIImage?
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(.normal)
            
            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
            context.clip(to: rect, mask: cgImage)
            context.fill(rect)
            
            newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return newImage ?? UIImage()
    }
	
    func exGetPixelColor(_ pos: CGPoint) -> String {
        
        let pixelData = self.cgImage?.dataProvider?.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = Int(data[pixelInfo])
        let g = Int(data[pixelInfo + 1])
        let b = Int(data[pixelInfo + 2])
        return String(format: "#%02x%02x%02x", r, g, b)
    }
    
    func exColorizeWithColor(_ color: UIColor) -> UIImage {
        var img: UIImage?
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        if let context: CGContext = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(CGBlendMode.normal)
            let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            context.clip(to: rect, mask: cgImage)
            color.setFill()
            context.fill(rect)
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return img ?? UIImage()
    }
    
    // Method rotates the UIImage by degrees provided and flips if required
    func imageRotatedByDegrees(_ degrees: CGFloat, flip: Bool) -> UIImage {
        let degreesToRadians: (CGFloat) -> CGFloat = {_ in
            return degrees / 180.0 * CGFloat(Double.pi)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees))
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
        
        //   // Rotate the image context
        bitmap?.rotate(by: degreesToRadians(degrees))
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if flip {
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        bitmap?.scaleBy(x: yFlip, y: -1.0)
        if let cgImage = cgImage {
            bitmap?.draw(cgImage, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? UIImage()
    }
	
	func rotateByRadians(_ radians: CGFloat, universeColor: UIColor) -> UIImage {
		let rotatedSize = CGRect(origin: .zero, size: size)
			.applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
			.integral.size
		UIGraphicsBeginImageContext(rotatedSize)
		if let context = UIGraphicsGetCurrentContext() {
			let origin = CGPoint(x: rotatedSize.width / 2.0,
								 y: rotatedSize.height / 2.0)
			context.translateBy(x: origin.x, y: origin.y)
			context.rotate(by: radians)
			draw(in: CGRect(x: -origin.y, y: -origin.x,
							width: size.width, height: size.height))
			let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			let coloredImage = rotatedImage?.withColor(universeColor)
			
			return coloredImage ?? self
		}
		
		return self
	}
	
	func withColor(_ color: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }
		color.setFill()
		ctx.translateBy(x: 0, y: size.height)
		ctx.scaleBy(x: 1.0, y: -1.0)
		ctx.clip(to: CGRect(x: 0, y: 0, width: size.width, height: size.height), mask: cgImage)
		ctx.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
		guard let colored = UIGraphicsGetImageFromCurrentImageContext() else { return self }
		UIGraphicsEndImageContext()
		return colored
	}

	func imageResize(_ sizeChange: CGSize) -> UIImage? {

        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen

        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
}
