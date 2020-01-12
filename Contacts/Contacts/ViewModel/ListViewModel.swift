//
//  ListViewModel.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import Foundation

class ListViewModel {
    var sections: [Section]!
    var actor: ContactActor
    
    init(with actor: ContactActor, onlyFavorites: Bool = false) {
        self.actor = actor
        self.actor.fetchContactsFromDataProvider(onlyFavorites: onlyFavorites, { response in
            if let result = response.result {
                self.sections = result
            }
            else {
                notifyUser(response.error!.rawValue)
            }
        })
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        
    }
}
