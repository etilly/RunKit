//
//  UITextField+Extension.swift
//  shootproof_ca
//
//  Created by Erwan BOUET on 22/01/2020.
//  Copyright © 2020 Niji. All rights reserved.
//

import UIKit

extension UITextField {
    func addMiddleDoneButton(doneAction: Selector, target: Any?) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "general_close".localized(), style: UIBarButtonItem.Style.done, target: target, action: doneAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        items.append(flexSpace)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        inputAccessoryView = doneToolbar
    }
}
