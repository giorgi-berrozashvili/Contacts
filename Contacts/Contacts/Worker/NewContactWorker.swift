//
//  NewContactWorker.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/16/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class NewContactWorker {
    static func fetchNewContactView(_ completion: @escaping (ApiResponse<[Section]>) -> ()) {
        var sections: [Section] = []
        
        let imageItem = [
            NewContactImageCellViewModel()
        ]
        let inputFieldItems = [
            NewContactInputCellViewModel(data: nil, type: .firstName, placeholder: "First name"),
            NewContactInputCellViewModel(data: nil, type: .lastName, placeholder: "Last name"),
            NewContactInputCellViewModel(data: nil, type: .company, placeholder: "Company")
        ]
        let phoneNumberItems = [
            NewContactAddPhoneCellViewModel()
        ]
        
        sections = [
            Section(items: imageItem),
            Section(items: inputFieldItems),
            Section(items: phoneNumberItems)
        ]
        completion(ApiResponse(with: sections))
    }
    
    static func updateContact(image: UIImage, in sections: inout [Section]) {
        
        var sectionIndex = -1, itemIndex = -1
        
        sections.enumerated().forEach({ (i, section) in
            section.items.enumerated().forEach({ (j, viewModel) in
                if viewModel is NewContactImageCellViewModel {
                    sectionIndex = i
                    itemIndex = j
                }
            })
        })
        
        sections[sectionIndex].items[itemIndex] = NewContactImageCellViewModel(with: image)
    }
    
    static func addNewPhoneField(to sections: inout [Section]) {
        
        var sectionIndex = -1
        
        sections.enumerated().forEach({ (i, section) in
            section.items.enumerated().forEach({ (j, viewModel) in
                if viewModel is NewContactInputCellViewModel {
                    sectionIndex = i
                }
            })
        })
        
        sections[sectionIndex].items.append(NewContactInputCellViewModel(data: nil, type: .phoneNumber, placeholder: "Phone number"))
    }
    
    static func saveNewContact(with model: [Section]) {
        var firstName: String!
        var lastName: String!
        var company: String!
        var phones: [MobileNumber] = []
        
        model.forEach({ section in
            section.items.forEach({ model in
                if let model = model as? NewContactInputCellViewModel {
                    switch model.type {
                    case .firstName: firstName = (model.data ?? "").capitalized
                    case .lastName: lastName = (model.data ?? "").capitalized
                    case .company: company = (model.data ?? "").capitalized
                    case .phoneNumber: phones.append(MobileNumber(description: "~", number: model.data ?? ""))
                    }
                }
            })
        })
        
        let contact = Contact(
            firstName: firstName,
            lastName: lastName,
            company: company,
            mobileNumbers: phones
        )
        
        ContactApi.add(contact: contact, { error in
            if let error = error {
                notifyUser(error.rawValue)
            }
        })
    }
}
