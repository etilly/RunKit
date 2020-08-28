//
//  ExtensionUIView.swift
//  shootproof
//
//  Created by Guillaume Elloy on 10/11/15.
//  Copyright © 2015 Valtech. All rights reserved.
//

import UIKit

extension UIView {
    
    func exSetFadeHidden(_ isHidden: Bool) {
        UIView.animate(withDuration: 1 / 3,
            animations: {
                if isHidden {
                    self.alpha = 0
                } else {
                    self.alpha = 0
                    self.isHidden = false
                    self.alpha = 1
                }
            },
            completion: { _ in
                self.isHidden = isHidden
            }
        )
    }
    
    func animShow() {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y - self.frame.height, width: self.superview?.frame.width ?? 0, height: self.frame.height)
                        //self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func animHide() {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        
        }, completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
	
	func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
    }
	
    func resize(_ size: CGSize) {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.frame.size = size
    }
}
