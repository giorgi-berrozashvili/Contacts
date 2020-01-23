//
//  ContactActor.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/12/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactActor {
    
    var viewController: ContactListViewController
    
    init(with viewController: ContactListViewController) {
        self.viewController = viewController
    }
    
    func fetchContacts(onlyFavorites: Bool = false, _ completion: @escaping (ApiResponse<[Section]>) -> ()) {
        ContactWorker.fetchContacts(onlyFavorites: onlyFavorites, completion)
    }
    
    func didTapCellFavoriteButtonWith(id: Int) {
        ContactWorker.toggleContactFavoriteStateBy(id: id, { response in
            if let error = response {
                notifyUser(error.rawValue)
            }
            else {
                self.viewController.refresh()
            }
        })
    }
    
    func didSelectContactCell(with cellItem: CellItem) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(identifier: "ContactDetail")
        viewController.present(controller, animated: true)
    }
    
    func showNewContactViewController() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(identifier: "ContactDetail")
        viewController.present(controller, animated: true)
        Notificator.addTask(with: "refresh.list.controller", { [weak self] in
            self?.viewController.refresh()
        })
    }
    
    func deleteRow(with model: CellItem) {
        if let model = model as? ContactCellViewModel {
            ContactWorker.removeContactBy(id: model.contactId, { response in
                if let response = response {
                    notifyUser(response.rawValue)
                }
                else {
                    self.viewController.refresh()
                }
            })
        }
        
    }
}
