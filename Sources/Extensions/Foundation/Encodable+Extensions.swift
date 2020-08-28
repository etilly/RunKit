//
//  Encodable+Extension.swift
//  shootproof
//
//  Created by Erwan TILLY on 27/01/2020.
//  Copyright © 2020 Niji. All rights reserved.
//

import Foundation

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
	
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
