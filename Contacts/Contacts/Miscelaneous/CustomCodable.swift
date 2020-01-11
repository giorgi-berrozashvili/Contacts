//
//  CustomCodable.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class Coder<T: Codable> {
    static func decode(from json: Data) -> T? {
        let decoder = JSONDecoder()
        let result = try? decoder.decode(T.self, from: json)
        return result as T?
    }

    static func encode(_ data: T) -> Data? {
        let encoder = JSONEncoder()
        let result = try? encoder.encode(data)
        return result
    }
}

