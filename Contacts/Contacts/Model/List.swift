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
    var nibName: String { get }
}

protocol Objectable: AnyObject { }

protocol Delegable {
    var delegate: Objectable? { get set }
}

protocol Configurable {
    var configurator: CellItem { get set }
}

struct Section {
    var items: [CellItem]
    var height: CGFloat = calculateProperHeight(with: 44)
    var title: String
    var titleFont = UIFont.boldSystemFont(ofSize: calculateProperWidth(with: 20))
}

struct ContactCellViewModel: CellItem {
    var height: CGFloat {
        return calculateProperHeight(with: 56)
    }
    var identificator: String {
        return "ContactCell"
    }
    var nibName: String {
        return "ContactCell"
    }
    var contactId: Int
    var title: String
    var isFavorite: Bool
}
