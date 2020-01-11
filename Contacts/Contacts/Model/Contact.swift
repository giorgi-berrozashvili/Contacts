//
//  Contact.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

struct MobileNumber: Codable {
    var description: String
    var number: String
}

struct Contact: Codable {
    
    static var identityProvider: Int = 0
    var id: Int
    var firstName: String
    var lastName: String?
    var company: String?
    var isFavorite: Bool
    var mobileNumbers: [MobileNumber]
    var groupIdentificator: String {
        if let lastName = lastName {
            return String(lastName.first!)
        }
        else {
            return String(firstName.first!)
        }
    }
    var imageInitials: String {
        return "\(firstName[0])\(lastName?[0] ?? "\0")"
    }
    
    init(firstName: String, lastName: String?, company: String?, mobileNumbers: [MobileNumber]) {
        
        Contact.identityProvider += 1
        
        self.id = Contact.identityProvider
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.mobileNumbers = mobileNumbers
        self.isFavorite = false
    }
}
