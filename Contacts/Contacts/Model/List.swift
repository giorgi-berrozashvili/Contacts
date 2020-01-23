//
//  List.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

protocol CellItem {
    var height: CGFloat { get }
    var identificator: String { get }
    var nibName: String { get }
}

protocol Objectable: AnyObject { }

protocol Delegable {
    var delegate: Objectable? { get set }
}

protocol Configurable {
    var configurator: CellItem { get set }
}

class Section {
    var items: [CellItem]
    var height: CGFloat
    var title: String?
    var titleFont = UIFont.boldSystemFont(ofSize: calculateProperWidth(with: 20))
    
    init(items: [CellItem], height: CGFloat = calculateProperHeight(with: 28), title: String? = nil) {
        self.items = items
        self.height = height
        self.title = title
    }
}

class NewContactImageCellViewModel: CellItem {
    var height: CGFloat {
        return calculateProperHeight(with: 180)
    }
    var identificator: String {
        return "NewContactImageCell"
    }
    var nibName: String {
        return "ContactImageCell"
    }
    var image: UIImage?

    init(with image: UIImage? = nil) {
        self.image = image
    }
}

enum ContactDataType {
    case firstName
    case lastName
    case company
    case phoneNumber
}

class NewContactInputCellViewModel: CellItem {
    var height: CGFloat {
        return calculateProperHeight(with: 50)
    }
    var identificator: String {
        return "NewContactInputCell"
    }
    var nibName: String {
        return "ContactInputCell"
    }
    var data: String?
    var type: ContactDataType
    var placeholder: String
    
    init(data: String? = nil, type: ContactDataType, placeholder: String) {
        self.data = data
        self.type = type
        self.placeholder = placeholder
    }
}

class NewContactAddPhoneCellViewModel: CellItem {
    var height: CGFloat {
        return calculateProperHeight(with: 48)
    }
    var identificator: String {
        return "NewContactAddPhoneCell"
    }
    var nibName: String {
        return "AddPhoneContactCell"
    }
}

class ContactCellViewModel: CellItem {
    var height: CGFloat {
        return calculateProperHeight(with: 56)
    }
    var identificator: String {
        return "ContactCell"
    }
    var nibName: String {
        return "ContactCell"
    }
    var contactId: Int
    var title: String
    var isFavorite: Bool
    
    init(contactId: Int, title: String, isFavorite: Bool) {
        self.contactId = contactId
        self.title = title
        self.isFavorite = isFavorite
    }
}
