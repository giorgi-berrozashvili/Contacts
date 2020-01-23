//
//  ContactDetailWorker.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/23/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactDetailWorker {
    static func fetchContactDetailView(with id: Int, _ completion: @escaping (ApiResponse<[Section]>) -> ()) {
        ContactApi.get(by: id, { response in
            if let contact = response.result {

                let headerItems = [
                    ContactDetailHeaderCellViewModel(
                        profileImage: nil,
                        username: contact.fullName,
                        company: contact.company
                    )
                ]
                
                let buttonItems = [
                    ContactDetailFunctionalCellViewModel(buttonModels: [
                        ContactDetailButtonViewModel(
                            icon: UIImage.init(systemName: "message.circle")!,
                            title: "message",
                            isActive: true
                        ),
                        ContactDetailButtonViewModel(
                            icon: UIImage.init(systemName: "phone.circle")!,
                            title: "call",
                            isActive: false
                        ),
                        ContactDetailButtonViewModel(
                            icon: UIImage.init(systemName: "video.circle")!,
                            title: "video",
                            isActive: false
                        ),
                        ContactDetailButtonViewModel(
                            icon: UIImage.init(systemName: "envelope.circle")!,
                            title: "mail",
                            isActive: true
                        )
                    ])
                ]
                
                let sections: [Section] = [
                    Section(items: headerItems),
                    Section(items: buttonItems)
                ]
                completion(ApiResponse(with: sections))
            }
            else {
                completion(ApiResponse(withError: response.error!))
            }
        })
    }
}
