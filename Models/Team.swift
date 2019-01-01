//
//  Team.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import Foundation
import CloudKit

class Team {
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - PROPERTIES
    
    // General team info
    var coach: String
    var name: String
    var color: String
    
    // Team record
    var wins: Int
    var losses: Int
    var rank: Int
    var gamesPlayed: Int {
        return wins + losses
    }
    
    // Team stats
    var completionsAttempted: Int
    var completionsMade: Int
    var interceptionsThrown: Int
    var fieldGoalsMade: Int
    var fieldGoalsAttempted: Int
    var pATsMade: Int
    var pATsAttempted: Int
    var touchdowns: Int
    var twoPointConversions: Int
    var interceptionsCaught: Int
    
    // CloudKit variables
    var leagueReference: CKRecord.Reference
//    var gameReferences: [CKRecord.Reference]
    var ckRecordID: CKRecord.ID?
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - KEYS
    
    static let teamTypeKey = "Team"
    
    // General team info
    fileprivate static let coachKey = "coach"
    fileprivate static let nameKey = "name"
    fileprivate static let colorKey = "color"
    
    // Team record
    fileprivate static let winsKey = "wins"
    fileprivate static let lossesKey = "losses"
    fileprivate static let rankKey = "rank"
    
    // Team stats
    fileprivate static let completionsAttemptedKey = "completionsAttempted"
    fileprivate static let completionsMadeKey = "completionsMade"
    fileprivate static let interceptionsThrownKey = "interceptionsThrown"
    fileprivate static let fieldGoalsMadeKey = "fieldGoalsMade"
    fileprivate static let fieldGoalsAttemptedKey = "fieldGoalsAttempted"
    fileprivate static let pATsMadeKey = "pATsMade"
    fileprivate static let pATsAttemptedKey = "pATsAttempted"
    fileprivate static let touchdownsKey = "touchdowns"
    fileprivate static let twoPointConversionsKey = "twoPointConversions"
    fileprivate static let interceptionsCaughtKey = "interceptionsCaught"
    
    // CloudKit variables
    fileprivate static let leagueReferenceKey = "leagueReference"
    fileprivate static let gameReferencesKey = "gameReferences"
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - MEMBERWISE INITIALIZER
    
    init(
    
        // General team info
        coach: String,
        name: String,
        color: String,
    
        // Team record
        wins: Int = 0,
        losses: Int = 0,
        rank: Int = 0,
    
        // Team stats
        completionsAttempted: Int = 0,
        completionsMade: Int = 0,
        interceptionsThrown: Int = 0,
        fieldGoalsMade: Int = 0,
        fieldGoalsAttempted: Int = 0,
        pATsMade: Int = 0,
        pATsAttempted: Int = 0,
        touchdowns: Int = 0,
        twoPointConversions: Int = 0,
        interceptionsCaught: Int = 0,
    
        // CloudKit variables
        leagueReference: CKRecord.Reference
//        , gameReferences: [CKRecord.Reference]
        ) {
        
        // General team info
        self.coach = coach
        self.name = name
        self.color = color
        
        // Team record
        self.wins = wins
        self.losses = losses
        self.rank = rank
        
        // Team stats
        self.completionsAttempted = completionsAttempted
        self.completionsMade = completionsMade
        self.interceptionsThrown = interceptionsThrown
        self.fieldGoalsMade = fieldGoalsMade
        self.fieldGoalsAttempted = fieldGoalsAttempted
        self.pATsMade = pATsMade
        self.pATsAttempted = pATsAttempted
        self.touchdowns = touchdowns
        self.twoPointConversions = twoPointConversions
        self.interceptionsCaught = interceptionsCaught
        
        // CloudKit variables
        self.leagueReference = leagueReference
//        self.gameReferences = gameReferences
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - INITIALIZE MODEL OBJECT FROM CKRECORD
    
    init?(ckRecord: CKRecord) {
        
        // Unpack values
        
        // General team info
        guard let coach = ckRecord[Team.coachKey] as? String,
        let name = ckRecord[Team.nameKey] as? String,
        let color = ckRecord[Team.colorKey] as? String,
        
        // Team record
        let wins = ckRecord[Team.winsKey] as? Int,
        let losses = ckRecord[Team.lossesKey] as? Int,
        let rank = ckRecord[Team.rankKey] as? Int,
        
        // Team stats
        let completionsAttempted = ckRecord[Team.completionsAttemptedKey] as? Int,
        let completionsMade = ckRecord[Team.completionsMadeKey] as? Int,
        let interceptionsThrown = ckRecord[Team.interceptionsThrownKey] as? Int,
        let fieldGoalsMade = ckRecord[Team.fieldGoalsMadeKey] as? Int,
        let fieldGoalsAttempted = ckRecord[Team.fieldGoalsAttemptedKey] as? Int,
        let pATsMade = ckRecord[Team.pATsMadeKey] as? Int,
        let pATsAttempted = ckRecord[Team.pATsAttemptedKey] as? Int,
        let touchdowns = ckRecord[Team.touchdownsKey] as? Int,
        let twoPointConversions = ckRecord[Team.twoPointConversionsKey] as? Int,
        let interceptionsCaught = ckRecord[Team.interceptionsCaughtKey] as? Int,
        
        // CloudKit variables
        let leagueReference = ckRecord[Team.leagueReferenceKey] as? CKRecord.Reference
        
        else { return nil }
        
        // Set as values of new instance
        
        // General team info
        self.coach = coach
        self.name = name
        self.color = color
        
        // Team record
        self.wins = wins
        self.losses = losses
        self.rank = rank
        
        // Team stats
        self.completionsAttempted = completionsAttempted
        self.completionsMade = completionsMade
        self.interceptionsThrown = interceptionsThrown
        self.fieldGoalsMade = fieldGoalsMade
        self.fieldGoalsAttempted = fieldGoalsAttempted
        self.pATsMade = pATsMade
        self.pATsAttempted = pATsAttempted
        self.touchdowns = touchdowns
        self.twoPointConversions = twoPointConversions
        self.interceptionsCaught = interceptionsCaught
        
        // CloudKit variables
        self.leagueReference = leagueReference
        
        self.ckRecordID = ckRecord.recordID
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - INITIALIZE CKRECORD FROM MODEL OBJECT

extension CKRecord {
    
    convenience init(team: Team) {
        
        // Use existing ckRecordID or create new one and give it UUID (convert to string)
        let recordID = team.ckRecordID ?? CKRecord.ID(recordName: UUID().uuidString)
        
        // Now initialize ckRecordID as string version (recordID)
        self.init(recordType: Team.teamTypeKey, recordID: recordID)
        
        // Set CKRecord values
        
        // General team info
        self.setValue(team.coach, forKey: Team.coachKey)
        self.setValue(team.name, forKey: Team.nameKey)
        self.setValue(team.color, forKey: Team.colorKey)
        
        // Team record
        self.setValue(team.wins, forKey: Team.winsKey)
        self.setValue(team.losses, forKey: Team.lossesKey)
        self.setValue(team.rank, forKey: Team.rankKey)
        
        // Team stats
        self.setValue(team.completionsAttempted, forKey: Team.completionsAttemptedKey)
        self.setValue(team.completionsMade, forKey: Team.completionsMadeKey)
        self.setValue(team.interceptionsThrown, forKey: Team.interceptionsThrownKey)
        self.setValue(team.fieldGoalsMade, forKey: Team.fieldGoalsMadeKey)
        self.setValue(team.fieldGoalsAttempted, forKey: Team.fieldGoalsAttemptedKey)
        self.setValue(team.pATsMade, forKey: Team.pATsMadeKey)
        self.setValue(team.pATsAttempted, forKey: Team.pATsAttemptedKey)
        self.setValue(team.touchdowns, forKey: Team.touchdownsKey)
        self.setValue(team.twoPointConversions, forKey: Team.twoPointConversionsKey)
        self.setValue(team.interceptionsCaught, forKey: Team.interceptionsCaughtKey)
        
        // CloudKit variables
        self.setValue(team.leagueReference, forKey: Team.leagueReferenceKey)
                
        // Give new ckRecord new ID (or pass along existing)
        team.ckRecordID = recordID
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - EQUATABLE EXTENSION

extension Team: Equatable {
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}
