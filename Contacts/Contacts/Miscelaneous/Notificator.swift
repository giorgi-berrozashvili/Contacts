//
//  Notificator.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/23/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class Notificator {
    
    private static var coordinator: [String: (Int) -> ()] = [:]
    
    static func notify(with identifier: String, value: Int = 0) {
        Notificator.coordinator[identifier]!(value)
    }
    
    static func addTask(with identifier: String, _ task: @escaping (Int) -> ()) {
        Notificator.coordinator[identifier] = task
    }
}
