//
//  ListViewModel.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import Foundation

class ContactViewModel {
    var sections: [Section] = []
    var actor: ContactActor
    var loadedOnlyFavorites: Bool = false
    lazy var keywords = Keywords.of(type: self)! as! ContactListKeywords
    
    init(with actor: ContactActor, onlyFavorites: Bool = false) {
        self.actor = actor
        self.actor.fetchContacts(onlyFavorites: onlyFavorites, { [weak self] response in
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
}

extension ContactViewModel: Keywordable {
    var type: Keywords.Type {
        return ContactListKeywords.self
    }
    
    var identifier: String {
        return "ContactKeywords"
    }
}
