//
//  ContactDataProvider.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/12/20.
//  Copyright © 2020 GB. All rights reserved.
//

import Foundation

class ContactDataProvider {
    static func createContactViewModel(_ completion: @escaping (ApiResponse<ListViewModel>) -> ()) {
        ContactApi.get({ response in
            if let result = response.result {
                completion(ApiResponse(with: ListViewModel(with: result)))
            }
            else if let error = response.error {
                completion(ApiResponse(withError: error))
            }
            else {
                completion(ApiResponse(withError: .unknown))
            }
        })
    }
}
