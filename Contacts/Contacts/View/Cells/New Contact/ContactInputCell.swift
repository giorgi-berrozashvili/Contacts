//
//  ContactInputCell.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/21/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactInputCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    var model: NewContactInputCellViewModel! {
        didSet {
            configureVisualAspects()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self
    }
    
    func configureVisualAspects() {
        
        let fontSize = calculateProperWidth(with: 18)
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.placeholder = model.placeholder
        
        switch model.type {
        case .firstName, .lastName:
            textField.textContentType = .name
        case .company:
            textField.textContentType = .organizationName
        case .phoneNumber:
            textField.textContentType = .telephoneNumber
        }
    }
}

extension ContactInputCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        model.data = textField.text
    }
}

extension ContactInputCell: Configurable {
    var configurator: CellItem {
        get {
            return model
        }
        set {
            if let value = newValue as? NewContactInputCellViewModel {
                model = value
            }
        }
    }
}

