//
//  NewContactViewModel.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/16/20.
//  Copyright © 2020 GB. All rights reserved.
//

import Foundation

class NewContactViewModel {
    var actor: NewContactActor
    var sections: [Section] = []
    
    init(with actor: NewContactActor) {
        self.actor = actor
        actor.fetchNewContactView({ sections in
            if let sections = sections.result {
                self.sections = sections
            }
            else {
                notifyUser(sections.error!.rawValue)
            }
        })
    }
}
