//
//  BaseReusable.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/23/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class BaseReusableView : UIView {
    
    var nibIdentifier: String? {
        get {
            return nil
        }
    }
    
    @IBOutlet var contentView:UIView!
    
    init() {
        super.init(frame: CGRect.zero)
        self._configure()
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._configure()
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._configure()
        self.configure()
    }
    
    private func _configure() {
        if let identifier = self.nibIdentifier {
            Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
            guard let content = contentView else { return }
            self.addSubview(content)
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[c]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["c":content]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[c]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["c":content]))
            content.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func configure() {
        
    }
}
