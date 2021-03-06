//
//  Extensions.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

let ContactKey = "contact_key"
let KeywordPList = "Keywords"
let PlistType = "plist"

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

func notifyUser(_ text: String) {
    print(text)
}

func makeRounded(_ view: UIView) {
    //view.layer.cornerRadius = view.bounds.height / 2
    //view.clipsToBounds = true
}

extension Array where Element == Section {
    subscript(_ indexPath: IndexPath) -> CellItem {
        return self[indexPath.section].items[indexPath.row]
    }
}

extension Dictionary {
    static func fromPropertyList(named list: String) -> Dictionary<String, [String: String]>? {
        var ns: NSDictionary?
        if let path = Bundle.main.path(forResource: list, ofType: PlistType) {
           ns = NSDictionary(contentsOfFile: path)
        }
        return ns as? [String: [String: String]]
    }
}

extension UILabel {
    @IBInspectable var fontSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            self.font = UIFont(name: font.familyName, size: calculateProperWidth(with: newValue))
        }
    }
}

extension UITextField {
    @IBInspectable var fontSize: CGFloat {
        get {
            return self.font?.pointSize ?? 0
        }
        set {
            self.font = UIFont(name: font?.familyName ?? "", size: calculateProperWidth(with: newValue))
        }
    }
}

extension UIButton {
    @IBInspectable var titleFontSize: CGFloat {
        get {
            return self.titleLabel?.font.pointSize ?? 0
        }
        set {
            self.titleLabel?.font = UIFont(name: titleLabel?.font.familyName ?? "", size: calculateProperWidth(with: newValue))
        }
    }
}

extension UITableViewCell {
    func toggleSeparator(_ value: Bool) {
        if value {
            separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        else {
            separatorInset = UIEdgeInsets(top: 0, left: bounds.size.width, bottom: 0, right: 0)
        }
    }
}

protocol Bindable {
    var binder: Any! { get set }
}
