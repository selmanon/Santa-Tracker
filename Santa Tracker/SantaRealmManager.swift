//
//  SantaRealmManager.swift
//  Santa Tracker
//
//  Created by Abdellah SELASSI on 12/18/16.
//  Copyright © 2016 Dial. All rights reserved.
//

import Foundation
import RealmSwift

class SantaRealmManager {
    // Properties
    private let username = "santatracker@realm.io"
    private let password = "h0h0h0"
    
    private let authServerURL = URL(string: "http://162.243.150.99:9080")!
    private let syncServerURL = URL(string: "realm://162.243.150.99:9080/santa")!
    
    private var user: SyncUser?

    // logIn
    func logIn(completion: ((Void)->Void)? = nil) {
        guard user == nil else {
            completion?()
            return
        }
        
        let credentials = SyncCredentials.usernamePassword(username: username, password: password)
        SyncUser.logIn(with: credentials, server: authServerURL) {
            user, error in
            if let user = user {
                self.user = user
                DispatchQueue.main.async {
                    completion?()
                }
            } else if let error = error {
                fatalError("Could not log in: \(error)")
            }
        }
    }
    
    func realm() -> Realm? {
        if let user = user {
            let syncConfig = SyncConfiguration(user: user, realmURL: syncServerURL)
            let config = Realm.Configuration(syncConfiguration: syncConfig)
            guard let realm = try? Realm(configuration: config) else {
                fatalError("Could not load Realm")
            }
            return realm
        } else {
            return nil
        }
    }
    
    
}
