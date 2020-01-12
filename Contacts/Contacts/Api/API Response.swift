//
//  API Response.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/12/20.
//  Copyright © 2020 GB. All rights reserved.
//

import Foundation

enum ErrorType: String {
    case decode = "Could not decode"
    case empty = "User defaults is empty"
    case encode = "Could not encode contacts"
    case unknown = "Unknown error occurred"
    case notFound = "Such record was not found"
}

class ApiResponse<T> {
    
    var result: T?
    var error: ErrorType?
    
    init(with data: T?) {
        self.result = data
    }
    init(withError error: ErrorType) {
        self.error = error
    }
}
