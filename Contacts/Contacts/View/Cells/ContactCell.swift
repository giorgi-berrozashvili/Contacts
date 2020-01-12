//
//  ContactCell.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

protocol ContactCellDelegate: Objectable {
    func didTapStarButton(_ id: Int)
}

class ContactCell: UITableViewCell, Delegable {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIButton!
    weak var delegate: Objectable?
    
    var model: ContactCellViewModel! {
        didSet {
            title.text = model.title
            
            let image = model.isFavorite
                ? UIImage(systemName: "star.fill")
                : UIImage(systemName: "star")
            
            icon.setImage(image, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        icon.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        if let delegate = delegate as? ContactCellDelegate {
            delegate.didTapStarButton(model.contactId)
        }
    }
}

extension ContactCell: Configurable {
    var configurator: CellItem {
        get {
            return model
        }
        set {
            if let config = newValue as? ContactCellViewModel {
                model = config
            }
        }
    }
}
