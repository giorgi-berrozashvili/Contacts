//
//  Keywords.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/14/20.
//  Copyright © 2020 GB. All rights reserved.
//

import Foundation

protocol Keywordable {
    var identifier: String { get }
    var type: Keywords.Type { get }
}

class Keywords {
    static func of(type: Keywordable) -> Keywords? {
        if let plist = Dictionary<String, String>.fromPropertyList(named: KeywordPList) {
            if let keywords = plist[type.identifier] {
                return type.type.init(with: keywords)
            }
        }
        return nil
    }
    required init?(with map: [String: String]) {
        // override in subclasses
    }
}

class ContactListKeywords: Keywords {
    var deleteWithSwipe: String!
    var star: String!
    var filledStar: String!
    
    required init?(with map: [String : String]) {
        super.init(with: map)
        
        self.deleteWithSwipe = map["deleteWithSwipe"]
        self.star = map["star"]
        self.filledStar = map["filledStar"]
    }
}
