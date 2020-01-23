//
//  DynamicFontViewController.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/21/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class DynamicFontViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iterate(from: view)
    }
    
    private func iterate(from view: UIView) {
        view.subviews.forEach({ subview in
            iterate(from: subview)
        })
        if let label = view as? UILabel {
            label.font = UIFont.init(name: label.font.fontName, size: calculateProperWidth(with: label.font.pointSize))
        }
        if let button = view as? UIButton {
            if let title = button.titleLabel {
                title.font = UIFont.init(name: title.font.fontName, size: calculateProperWidth(with: title.font.pointSize))
            }
        }
    }
}
