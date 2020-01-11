//
//  ContactCell.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}

extension ContactCell: Configurable {
    func configure(with item: CellItem) {
        if let item = item as? ContactCellViewModel {
            title.text = item.title
            
            let image = item.isFavorite
            ? UIImage(systemName: "star.fill")
            : UIImage(systemName: "star")
            
            icon.setImage(image, for: .normal)
        }
    }
    
}
