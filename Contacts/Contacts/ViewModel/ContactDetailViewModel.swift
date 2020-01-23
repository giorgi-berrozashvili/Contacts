//
//  ContactDetailViewModel.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/13/20.
//  Copyright © 2020 GB. All rights reserved.
//

import Foundation

class ContactDetailViewModel {
    var sections: [Section] = []
    var actor: ContactDetailActor!
    var contactId: Int = -2
    
    init(with actor: ContactDetailActor) {
        self.actor = actor
        actor.fetchDetailView(with: contactId, { response in
            if let result = response.result {
                self.sections = result
            }
            else {
                notifyUser(response.error!.rawValue)
            }
        })
    }
}
