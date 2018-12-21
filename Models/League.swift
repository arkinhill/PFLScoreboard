//
//  League.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import Foundation
import CloudKit

class League {
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - PROPERTIES
    
    // League info
    var leagueName: String
    var isPending: Bool
    
    // League arrays
    var teams: [Team]
    var users: [User]
    
    // CloudKit variables
    let appleUserReference: CKRecord.Reference
    var ckRecordID: CKRecord.ID?
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - KEYS
    
    static let leagueTypeKey = "League"
    
    // League info
    fileprivate static let leagueNameKey = "leagueName"
    fileprivate static let isPendingKey = "isPending"
    
    // League arrays
    fileprivate static let teamsKey = "teams"
    fileprivate static let usersKey = "users"
    
    // CloudKit variables
    fileprivate static let appleUserReferenceKey = "appleUserReference"
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - MEMBERWISE INITIALIZER
    
    init(leagueName: String, isPending: Bool, teams: [Team], users: [User], appleUserReference: CKRecord.Reference) {
        
        // League info
        self.leagueName = leagueName
        self.isPending = isPending
        
        // League arrays
        self.teams = teams
        self.users = users
        
        // CloudKit variables
        self.appleUserReference = appleUserReference
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - INITIALIZE MODEL OBJECT FROM CKRECORD
    
    init?(ckRecord: CKRecord) {
        
        // Unpack values
        
        // League info
        guard let leagueName = ckRecord[League.leagueNameKey] as? String,
            let isPending = ckRecord[League.isPendingKey] as? Bool,
            
            // League arrays
            let teams = ckRecord[League.teamsKey] as? [Team],
            let users = ckRecord[League.usersKey] as? [User],
            
            // CloudKit variables
            let appleUserReference = ckRecord[League.appleUserReferenceKey] as? CKRecord.Reference
            
            else { return nil }
        
        // Set as the values of new instance
        
        // League info
        self.leagueName = leagueName
        self.isPending = isPending
        
        // League arrays
        self.teams = teams
        self.users = users
        
        // CloudKit variables
        self.appleUserReference = appleUserReference
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - INITIALIZE CKRECORD FROM MODEL OBJECT

extension CKRecord {
    
    convenience init(league: League) {
        
        // Use existing ckRecordID or create new one and give it UUID (convert to string)
        let recordID = league.ckRecordID ?? CKRecord.ID(recordName: UUID().uuidString)
        
        // Now initialize ckRecordID as string version (recordID)
        self.init(recordType: League.leagueTypeKey, recordID: recordID)
        
        // Set CKRecord values
        
        // League info
        self.setValue(league.leagueName, forKey: League.leagueNameKey)
        self.setValue(league.isPending, forKey: League.isPendingKey)
        
        // League arrays
        self.setValue(league.teams, forKey: League.teamsKey)
        self.setValue(league.users, forKey: League.usersKey)
        
        // CloudKit variables
        self.setValue(league.appleUserReference, forKey: League.appleUserReferenceKey)
        
        // Give new ckRecord new ID (or pass along existing)
        league.ckRecordID = recordID
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - EQUATABLE EXTENSION

extension League: Equatable {
    
    static func == (lhs: League, rhs: League) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}
