//
//  ExtensionUINavigationController.swift
//  shootproof
//
//  Created by Guillaume Elloy on 09/11/15.
//  Copyright © 2015 Valtech. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func exPushFadeViewController(_ viewController: UIViewController) {
        self.exFadeAnimation()
        self.pushViewController(viewController, animated: false)
    }
    
    func exPopFadeViewController() {
        self.exFadeAnimation()
        self.popViewController(animated: false)
    }
    
    func exPopFadeToRootViewController() {
        self.exFadeAnimation()
        self.popToRootViewController(animated: false)
    }
    
    private func exFadeAnimation() {
        let transition = CATransition()
        transition.duration = 1 / 3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey: nil)
    }
}
