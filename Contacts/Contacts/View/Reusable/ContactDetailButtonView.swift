//
//  ContactDetailButtonView.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/23/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactDetailButtonView: BaseReusableView {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var model: ContactDetailButtonViewModel! {
        didSet {
            self.icon.image = model.icon
            self.title.text = model.title
            self.icon.tintColor = model.isActive ? UIColor.systemBlue : UIColor.systemGray
            
            makeRounded(icon)
        }
    }
    
    override var nibIdentifier: String? {
        return "ContactDetailButtonView"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        makeRounded(icon)
    }
}
