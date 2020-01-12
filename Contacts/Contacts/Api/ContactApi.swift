//
//  ContactApi.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactApi {
    static func get(_ completion: @escaping (ApiResponse<[Contact]>) -> ()) {
        guard let data = UserDefaults.standard.data(forKey: ContactKey) else {
            completion(ApiResponse(withError: .empty))
            return
        }
        let result = Coder<[Contact]>.decode(from: data)
        if let result = result {
            completion(ApiResponse(with: result))
        }
        else {
            completion(ApiResponse(withError: .decode))
        }
    }
    
    static func add(contact: Contact, _ completion: @escaping (ErrorType?) -> ()) {
        get({ response in
            if var response = response.result {
                
                var contactCopy = contact
                if contactCopy.id == -1 {
                    contactCopy.id = response.count + 1
                }
                
                response.append(contactCopy)
                let data = Coder<[Contact]>.encode(response)
                guard data != nil else {
                    completion(.encode)
                    return
                }
                UserDefaults.standard.set(data, forKey: ContactKey)
                UserDefaults.standard.synchronize()
                completion(nil)
            }
            else {
                if let error = response.error {
                    if error == .empty {
                        
                        var contactCopy = contact
                        contactCopy.id = 1
                        
                        let data = Coder<[Contact]>.encode([contactCopy])
                        guard data != nil else {
                            completion(.encode)
                            return
                        }
                        UserDefaults.standard.set(data, forKey: ContactKey)
                        UserDefaults.standard.synchronize()
                        completion(nil)
                    }
                }
                else {
                    completion(.unknown)
                }
            }
        })
    }
    
    static func get(by id: Int, _ completion: @escaping (ApiResponse<Contact>) -> ()) {
        get({ response in
            if let contacts = response.result {
                let contact = contacts.first(where: { c in c.id == id})
                if let contact = contact {
                    completion(ApiResponse(with: contact))
                }
                else {
                    completion(ApiResponse(withError: .notFound))
                }
            }
            else if let error = response.error {
                completion(ApiResponse(withError: error))
            }
            else {
                completion(ApiResponse(withError: .unknown))
            }
        })
    }
    
    static func remove(by id: Int, _ completion: @escaping (ErrorType?) -> ()) {
        get({ response in
            if var response = response.result {
                response.removeAll(where: { c in c.id == id })
                let data = Coder<[Contact]>.encode(response)
                guard data != nil else {
                    completion(.encode)
                    return
                }
                UserDefaults.standard.set(data, forKey: ContactKey)
                UserDefaults.standard.synchronize()
                completion(nil)
            }
            else {
                completion(.empty)
            }
        })
    }
    
    static func replace(by id: Int, with contact: Contact, _ completion: @escaping (ErrorType?) -> ()) {
        remove(by: id, { response in
            var errorType: ErrorType? = nil
            
            var contactCopy = contact
            contactCopy.id = id
            
            add(contact: contactCopy, { addResponse in
                if addResponse != nil {
                    errorType = addResponse
                }
            })
            
            if let response = response {
                errorType = response
            }
            
            completion(errorType)
        })
    }
    
    static func clear() {
        UserDefaults.standard.set(nil, forKey: ContactKey)
        UserDefaults.standard.synchronize()
    }
}
