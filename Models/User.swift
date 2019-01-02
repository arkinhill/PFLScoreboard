//
//  User.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - PROPERTIES
    
    // Username
    let username: String
    var leagueInvitesReferences: [CKRecord.Reference]
    
    // User arrays
    var leagues: [League] = []
    var leagueInvites: [League] = []
    
    // CloudKit variables
    let appleUserReference: CKRecord.Reference
    var ckRecordID: CKRecord.ID?
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - KEYS
    
    static let userTypeKey = "User"
    
    // Username
    fileprivate static let usernameKey = "username"
    
    // User arrays
    fileprivate static let leaguesKey = "leagues"
    fileprivate static let leagueInvitesKey = "leagueInvites"
    
    // CloudKit variables
    fileprivate static let appleUserReferenceKey = "appleUserReference"
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - MEMBERWISE INITIALIZER
    
    init(username: String, appleUserReference: CKRecord.Reference) {
        
        // Username
        self.username = username
        
        // User arrays
//        self.leagues = leagues
//        self.leagueInvites = leagueInvites
        
        // CloudKit variables
        self.appleUserReference = appleUserReference
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - INITIALIZE MODEL OBJECT FROM CKRECORD
    
    init?(ckRecord: CKRecord) {
        
        // Username
        guard let username = ckRecord[User.usernameKey] as? String,
            
            // User arrays
            let leagues = ckRecord[User.leaguesKey] as? [League],
            let leagueInvites = ckRecord[User.leagueInvitesKey] as? [League],
            
            // CloudKit variables
            let appleUserReference = ckRecord[User.appleUserReferenceKey] as? CKRecord.Reference
            else { return nil }
        
        // Username
        self.username = username
        
        // User arrays
        self.leagues = leagues
        self.leagueInvites = leagueInvites
        
        // CloudKit variables
        self.appleUserReference = appleUserReference
        self.ckRecordID = ckRecord.recordID
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - INITIALIZE CKRECORD FROM MODEL OBJECT

extension CKRecord {
    
    convenience init(user: User) {
        
        // Use existing recordID or create new one and give it a UUID (convert to string)
        let recordID = user.ckRecordID ?? CKRecord.ID(recordName: UUID().uuidString)
        
        // Now initialize recordID
        self.init(recordType: User.userTypeKey, recordID: recordID)
        
        // Set CKRecord values
        
        // Username
        self.setValue(user.username, forKey: User.usernameKey)
        
        // User arrays
        self.setValue(user.leagues, forKey: User.leaguesKey)
        self.setValue(user.leagueInvites, forKey: User.leagueInvitesKey)
        
        // CloudKit variables
        self.setValue(user.appleUserReference, forKey: User.appleUserReferenceKey)
        
        // Give new CKRecord new ID (or pass along existing)
        user.ckRecordID = recordID
    }
}
// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - EQUATABLE EXTENSION

extension User: Equatable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}

