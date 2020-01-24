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
            
            var contact: Contact
            
            if let result = response.result {
                contact = result
            }
            else {
                contact = Contact(
                    firstName: "George",
                    lastName: "Bero",
                    company: "BOG",
                    mobileNumbers: [
                        MobileNumber(description: "Geocell", number: "505-45-34-11"),
                        MobileNumber(description: "Magti", number: "501-23-23-23")
                    ]
                )
            }
            
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
            
            let titleValueItems = contact.mobileNumbers.map({ number in
                ContactDetailTitleValueCellViewModel(title: number.description, value: number.number)
            })
            
            let sections: [Section] = [
                Section(items: headerItems),
                Section(items: buttonItems),
                Section(items: titleValueItems)
            ]
            
            completion(ApiResponse(with: sections))
        })
    }
}
