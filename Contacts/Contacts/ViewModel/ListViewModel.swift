//
//  ListViewModel.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import Foundation

class ListViewModel {
    var sections: [Section]
    
    init(with sections: [Section]) {
        self.sections = sections
    }
}
