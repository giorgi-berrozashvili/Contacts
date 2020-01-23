//
//  ContactDetailFunctionalCell.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/23/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactDetailFunctionalCell: UITableViewCell {

    @IBOutlet var buttonViews: [ContactDetailButtonView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    var model: ContactDetailFunctionalCellViewModel! {
        didSet {
            model.buttonModels.enumerated().forEach({ (index, buttonModel) in
                buttonViews[index].model = buttonModel
            })
        }
    }
}

extension ContactDetailFunctionalCell: Configurable {
    var configurator: CellItem {
        get {
            return model
        }
        set {
            if let value = newValue as? ContactDetailFunctionalCellViewModel {
                model = value
            }
        }
    }
}

