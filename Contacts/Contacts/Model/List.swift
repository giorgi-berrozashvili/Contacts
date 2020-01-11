//
//  List.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

protocol CellItem {
    var height: CGFloat { get }
    var identificator: String { get }
}

protocol Configurable {
    func configure(with item: CellItem)
}

struct Section {
    var items: [CellItem]
    var height: CGFloat
    var title: String
}

struct ContactCellViewModel: CellItem {
    var height: CGFloat {
        return calculateProperHeight(with: 60)
    }
    var identificator: String {
        return "ContactCell"
    }
    var title: String
    var isFavorite: Bool
}
