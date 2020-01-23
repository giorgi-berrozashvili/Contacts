//
//  ContactInputCell.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/13/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactInputCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    var model: NewContactInputCellViewModel! {
        didSet {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self
    }
}

extension ContactInputCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
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
