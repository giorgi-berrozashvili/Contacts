//
//  ContactImageCell.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/13/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

protocol ContactImageCellDelegate: Objectable {
    func didTapAddButton()
}

class ContactImageCell: UITableViewCell, Delegable {

    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate: Objectable?
    
    var model: NewContactImageCellViewModel! {
        didSet {
            if let image = model.image {
                contactImage.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addButton.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapAddButton(_ sender: UIButton) {
        if let delegate = delegate as? ContactImageCellDelegate {
            delegate.didTapAddButton()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contactImage.layer.cornerRadius = contactImage.frame.height / 2
        //contactImage.clipsToBounds = true
        contactImage.layer.masksToBounds = true
    }
}

extension ContactImageCell: Configurable {
    var configurator: CellItem {
        get {
            return model
        }
        set {
            if let value = newValue as? NewContactImageCellViewModel {
                model = value
            }
        }
    }
}
