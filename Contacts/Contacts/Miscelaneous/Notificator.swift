//
//  Notificator.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/23/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class Notificator {
    
    private static var coordinator: [String: () -> ()] = [:]
    
    static func notify(with identifier: String) {
        Notificator.coordinator[identifier]!()
    }
    
    static func addTask(with identifier: String, _ task: @escaping () -> ()) {
        Notificator.coordinator[identifier] = task
    }
}
