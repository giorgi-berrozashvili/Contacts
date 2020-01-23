//
//  ContactInfoCell.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/23/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactInfoCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    var model: ContactDetailHeaderCellViewModel! {
        didSet {
            profileImage.image = model.profileImage
            usernameLabel.text = model.username
            companyLabel.text = model.company
            
            prepareImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareImage()
    }
    
    func prepareImage() {
        
        if profileImage.image == nil {
            profileImage.image = UIImage(systemName: "person.fill")
        }
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
    }
    
}

extension ContactInfoCell: Configurable {
    var configurator: CellItem {
        get {
            return model
        }
        set {
            if let value = newValue as? ContactDetailHeaderCellViewModel {
                model = value
            }
        }
    }
}
