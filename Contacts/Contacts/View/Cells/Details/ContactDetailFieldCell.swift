//
//  ContactDetailFieldCell.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/24/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactDetailFieldCell: UITableViewCell {

    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var model: ContactDetailTitleValueCellViewModel! {
        didSet {
            detailLabel.text = model.title
            detailLabel.textColor = model.titleColor
            valueLabel.text = model.value
            valueLabel.textColor = model.valueColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}

extension ContactDetailFieldCell: Configurable {
    var configurator: CellItem {
        get {
            return model
        }
        set {
            if let value = newValue as? ContactDetailTitleValueCellViewModel {
                model = value
            }
        }
    }
}
