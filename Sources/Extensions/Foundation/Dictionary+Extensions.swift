//
//  Dictionary+Merge.swift
//  shootproof
//
//  Created by Jérémie GOAS on 20/06/2018.
//  Copyright © 2018 Valtech. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func update(other: Dictionary) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }
}
