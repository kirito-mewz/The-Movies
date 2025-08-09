//
//  BaseRepository.swift
//  The Movies
//
//  Created by Paing Htet on 09/08/2025.
//

import RealmSwift

class BaseRepository {
    
    let realm: Realm
    
    init() {
        
        var config = Realm.Configuration(schemaVersion: 1) // fresh start
        config.deleteRealmIfMigrationNeeded = true
        
        do {
            realm = try Realm(configuration: config)
            print("Default Realm file location: \(realm.configuration.fileURL?.absoluteString ?? "undefined")")
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
}
