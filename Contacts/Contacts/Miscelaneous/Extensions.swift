//
//  Extensions.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

let ContactKey = "contact_key"

struct iPhoneSE {
    static let width: CGFloat = 320
    static let height: CGFloat = 568
}

func calculateProperHeight(with seValue: CGFloat) -> CGFloat {
    return seValue * (UIScreen.main.bounds.height) / iPhoneSE.height
}

func calculateProperWidth(with seValue: CGFloat) -> CGFloat {
    return seValue * (UIScreen.main.bounds.width) / iPhoneSE.width
}

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
}
