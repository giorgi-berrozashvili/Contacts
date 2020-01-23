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
    /*
    init(with actor: ContactDetailActor) {
        self.actor = actor
        self.actor.fetchContacts(, { [weak self] response in
            guard let self = self else { return }
            if let result = response.result {
                self.sections = result
                self.loadedOnlyFavorites = onlyFavorites
            }
            else {
                notifyUser(response.error!.rawValue)
            }
        })
    }
    */
}
