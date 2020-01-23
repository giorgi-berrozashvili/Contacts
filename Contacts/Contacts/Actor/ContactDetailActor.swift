//
//  ContactDetailActor.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/16/20.
//  Copyright © 2020 GB. All rights reserved.
//

import Foundation

class ContactDetailActor {
    var viewController: ContactDetailController
    
    init(with viewController: ContactDetailController) {
        self.viewController = viewController
    }
}
