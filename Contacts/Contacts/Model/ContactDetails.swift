//
//  ContactDetails.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/23/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

struct ContactDetailButtonViewModel {
    var icon: UIImage
    var title: String
    var isActive: Bool
}


class ContactDetailHeaderCellViewModel: CellItem {
    var height: CGFloat {
        return calculateProperHeight(with: 156)
    }
    
    var identificator: String {
        return "ContactInfoCell"
    }
    
    var nibName: String {
        return "ContactInfoCell"
    }
    
    var hasSeparator: Bool {
        return false
    }
    
    var profileImage: UIImage?
    var username: String
    var company: String?
    
    init(profileImage: UIImage?, username: String, company: String?) {
        self.profileImage = profileImage
        self.username = username
        self.company = company
    }
    
}

class ContactDetailFunctionalCellViewModel: CellItem {
    var height: CGFloat {
        return calculateProperHeight(with: 96)
    }
    
    var identificator: String {
        return "ContactDetailFunctionalCell"
    }
    
    var nibName: String {
        return "ContactDetailFunctionalCell"
    }
    
    var buttonModels: [ContactDetailButtonViewModel]
    
    init(buttonModels: [ContactDetailButtonViewModel]) {
        self.buttonModels = buttonModels
    }
}

class ContactDetailTitleValueCellViewModel: CellItem {
    var height: CGFloat {
        return calculateProperHeight(with: 56)
    }
    
    var identificator: String {
        return "ContactDetailFieldCell"
    }
    
    var nibName: String {
        return "ContactDetailFieldCell"
    }
    
    var title: String
    var value: String
    var titleColor: UIColor
    var valueColor: UIColor
    
    init(title: String, value: String, titleColor: UIColor = .black, valueColor: UIColor = .systemBlue) {
        self.title = title
        self.value = value
        self.titleColor = titleColor
        self.valueColor = valueColor
    }
}

