//
//  FloattyBubble.swift
//  shootproof_ca
//
//  Created by GIL Henri on 07/05/2019.
//  Copyright © 2019 Niji. All rights reserved.
//

import Foundation
import UIKit

// FLOATTY BUTTON IN PJ AND HUMANIS SCREEN
class FloattyBubble: UIView {
    
    lazy var floattyBubble: UIButton = {
        let b = UIButton(frame: .zero)
        b.translatesAutoresizingMaskIntoConstraints=false
        b.backgroundColor = UIColor(netHex: 0xff0576A6)
        b.imageView?.image = UIImage(named: "ic_deaf")
        b.setImage(UIImage(named: "ic_deaf"), for: .normal)
        b.imageView?.contentMode = .scaleAspectFit
        b.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        b.addTarget(self, action: #selector(floattyBubbleAction), for: .touchUpInside)
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 2
        b.layer.masksToBounds = false
        b.layer.shadowOffset = CGSize(width: 1, height: 1)
        b.layer.shadowColor = UIColor.black.cgColor
        b.layer.shadowOpacity = 0.4
        b.layer.shadowRadius = 25
        b.layer.shouldRasterize = true
        b.layer.rasterizationScale = UIScreen.main.scale
        return b
    }()
    
    var actionHandler: (() -> Void)?
    var dispatchItem: DispatchWorkItem?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        floattyBubble.layer.cornerRadius = floattyBubble.frame.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(floattyBubble)
        NSLayoutConstraint.activate([
            floattyBubble.topAnchor.constraint(equalTo: topAnchor),
            floattyBubble.leadingAnchor.constraint(equalTo: leadingAnchor),
            floattyBubble.trailingAnchor.constraint(equalTo: trailingAnchor),
            floattyBubble.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showFloattyBubble() {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
            self?.floattyBubble.transform = CGAffineTransform(scaleX: 1, y: 1)
            self?.floattyBubble.alpha = 1
        })
    }
    
    public func hideFloattyBubble() {
        
        dispatchItem?.cancel()
        dispatchItem = DispatchWorkItem { [weak self] in
            self?.showFloattyBubble()
        }
		if let dispatchItem = dispatchItem {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: dispatchItem)
		}
        UIView.animate(withDuration: 0.4, animations: {[weak self] in
            self?.floattyBubble.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self?.floattyBubble.alpha=0.5
        })
    }
    
    @objc func floattyBubbleAction() {
        actionHandler?()
    }
}
