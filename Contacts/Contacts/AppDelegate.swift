//
//  AppDelegate.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /*
        var contact = Contact(
            firstName: "George",
            lastName: "Bero",
            company: "BOG",
            mobileNumbers: [
                MobileNumber(description: "Geocell", number: "505-45-34-11"),
                MobileNumber(description: "Magti", number: "501-23-23-23")
            ]
        )
        contact.id = -2
        
        ContactApi.add(contact: contact, { _ in })
        
        ContactApi.add(contact: Contact(
            firstName: "Jane",
            lastName: nil,
            company: "Apple",
            mobileNumbers: [
                MobileNumber(description: "Geocell", number: "505-45-34-11"),
                MobileNumber(description: "Magti", number: "501-23-23-23")
            ]
        ), { _ in })
        
        ContactApi.add(contact: Contact(
            firstName: "Julia",
            lastName: "Doe",
            company: "Apple",
            mobileNumbers: [
                MobileNumber(description: "Geocell", number: "505-45-34-11"),
                MobileNumber(description: "Magti", number: "501-23-23-23")
            ]
        ), { _ in })
        
        ContactApi.add(contact: Contact(
            firstName: "Aaron",
            lastName: nil,
            company: "Apple",
            mobileNumbers: [
                MobileNumber(description: "Geocell", number: "505-45-34-11"),
                MobileNumber(description: "Magti", number: "501-23-23-23")
            ]
        ), { _ in })*/
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

