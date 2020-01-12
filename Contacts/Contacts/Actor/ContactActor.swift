//
//  ContactActor.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/12/20.
//  Copyright © 2020 GB. All rights reserved.
//

import Foundation

class ContactActor {
    
    var viewController: ListViewController
    
    init(with viewController: ListViewController) {
        self.viewController = viewController
    }
    
    func fetchContactsFromDataProvider(onlyFavorites: Bool = false, _ completion: @escaping (ApiResponse<[Section]>) -> ()) {
        var sections: [Section] = []
        
        ContactApi.get({ response in
            if let result = response.result {
                
                var sorted = result.sorted(by: { (a, b) in a.id < b.id })
                if onlyFavorites {
                    sorted = sorted.filter({ contact in contact.isFavorite })
                }
                sorted = sorted.sorted(by: { (a, b) in
                    if let last1 = a.lastName, let last2 = b.lastName {
                        if last1 == last2 {
                            return a.firstName < b.firstName
                        }
                        return last1 < last2
                    }
                    if let last1 = a.lastName {
                        return last1 < b.firstName
                    }
                    if let last2 = b.lastName {
                        return a.firstName < last2
                    }
                    return a.firstName < b.firstName
                })
                
                var groupedContacts = [String: [Contact]]()
                sorted.forEach({ contact in
                    if groupedContacts[contact.groupIdentificator] != nil {
                        groupedContacts[contact.groupIdentificator]?.append(contact)
                    }
                    else {
                        groupedContacts[contact.groupIdentificator] = [contact]
                    }
                })
                
                groupedContacts.keys.sorted().forEach({ key in
                    let contacts = groupedContacts[key]!
                    sections.append( Section(
                        items: contacts.map({ c in
                            ContactCellViewModel(contactId: c.id, title: c.fullName, isFavorite: c.isFavorite)
                        }),
                        title: key
                    ))
                })
                completion(ApiResponse(with: sections))
            }
            else if let error = response.error {
                completion(ApiResponse(withError: error))
            }
            else {
                completion(ApiResponse(withError: .unknown))
            }
        })
        
        
    }
    
    func didSelectRowWith(data: CellItem) {
        guard let data = data as? ContactCellViewModel else { return }
        
    }
    
    func didTapCellFavoriteButtonWith(id: Int) {
        ContactApi.get(by: id, { response in
            if var contact = response.result {
                contact.isFavorite = !contact.isFavorite
                ContactApi.replace(by: id, with: contact, { replaceResponse in
                    if let error = replaceResponse {
                        notifyUser(error.rawValue)
                    }
                    else {
                        self.viewController.refresh()
                    }
                })
            }
            else {
                notifyUser(response.error!.rawValue)
            }
        })
    }
}
