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
    var letter: String
    
    // Team arrays
    var games: [Game]
    
    // Team record
    var wins: Int
    var losses: Int
    var rank: Int
    var gamesPlayed: Int
    
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
    var appleUserReference: CKRecord.Reference
    var ckRecordID: CKRecord.ID?
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - KEYS
    
    static let teamTypeKey = "Team"
    
    // General team info
    fileprivate static let coachKey = "coach"
    fileprivate static let nameKey = "name"
    fileprivate static let colorKey = "color"
    fileprivate static let letterKey = "letter"
    
    // Team arrays
    fileprivate static let gamesKey = "games"
    
    // Team record
    fileprivate static let winsKey = "wins"
    fileprivate static let lossesKey = "losses"
    fileprivate static let rankKey = "rank"
    fileprivate static let gamesPlayedKey = "gamesPlayed"
    
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
    fileprivate static let appleUserReferenceKey = "appleUserReference"
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - MEMBERWISE INITIALIZER
    
    init(
    
        // General team info
        coach: String,
        name: String,
        color: String,
        letter: String,
        
        // Team arrays
        games: [Game],
    
        // Team record
        wins: Int,
        losses: Int,
        rank: Int,
        gamesPlayed: Int,
    
        // Team stats
        completionsAttempted: Int,
        completionsMade: Int,
        interceptionsThrown: Int,
        fieldGoalsMade: Int,
        fieldGoalsAttempted: Int,
        pATsMade: Int,
        pATsAttempted: Int,
        touchdowns: Int,
        twoPointConversions: Int,
        interceptionsCaught: Int,
    
        // CloudKit variables
        appleUserReference: CKRecord.Reference) {
        
        // General team info
        self.coach = coach
        self.name = name
        self.color = color
        self.letter = letter
        
        // Team arrays
        self.games = games
        
        // Team record
        self.wins = wins
        self.losses = losses
        self.rank = rank
        self.gamesPlayed = gamesPlayed
        
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
        self.appleUserReference = appleUserReference
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - INITIALIZE MODEL OBJECT FROM CKRECORD
    
    init?(ckRecord: CKRecord) {
        
        // Unpack values
        
        // General team info
        guard let coach = ckRecord[Team.coachKey] as? String,
        let name = ckRecord[Team.nameKey] as? String,
        let color = ckRecord[Team.colorKey] as? String,
        let letter = ckRecord[Team.letterKey] as? String,
        
        // Team arrays
        let games = ckRecord[Team.gamesKey] as? [Game],
        
        // Team record
        let wins = ckRecord[Team.winsKey] as? Int,
        let losses = ckRecord[Team.lossesKey] as? Int,
        let rank = ckRecord[Team.rankKey] as? Int,
        let gamesPlayed = ckRecord[Team.gamesPlayedKey] as? Int,
        
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
        let appleUserReference = ckRecord[Team.appleUserReferenceKey] as? CKRecord.Reference
            
        else { return nil }
        
        // Set as values of new instance
        
        // General team info
        self.coach = coach
        self.name = name
        self.color = color
        self.letter = letter
        
        // Team arrays
        self.games = games
        
        // Team record
        self.wins = wins
        self.losses = losses
        self.rank = rank
        self.gamesPlayed = gamesPlayed
        
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
        self.appleUserReference = appleUserReference
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
        self.setValue(team.letter, forKey: Team.letterKey)
        
        // Team arrays
        self.setValue(team.games, forKey: Team.gamesKey)
        
        // Team record
        self.setValue(team.wins, forKey: Team.winsKey)
        self.setValue(team.losses, forKey: Team.lossesKey)
        self.setValue(team.rank, forKey: Team.rankKey)
        self.setValue(team.gamesPlayed, forKey: Team.gamesPlayedKey)
        
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
        self.setValue(team.appleUserReference, forKey: Team.appleUserReferenceKey)
        
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
