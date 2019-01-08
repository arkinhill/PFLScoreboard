//
//  Game.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import Foundation
import CloudKit

class Game {
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - PROPERTIES
    
    // Game info
    var date: Date?
    var team1: Team?
//    {
//        didSet {
//            team1Name = team.name
//            team1Color = team1.color.rawValue
//            team1Coach = team1.coach
//        }
//    }
    var team2: Team?
//    {
//        didSet {
//            team2Name = team2.name
//            team2Coach = team2.coach
//            team2Color = team2.color.rawValue
//        }
//    }

    var team1Name: String
    var team1Color: String
    var team1Coach: String
    var team1CKRecordID: CKRecord.ID?
    
    var team2Name: String
    var team2Color: String
    var team2Coach: String
    var team2CKRecordID: CKRecord.ID?
    
// ❎ NEED TO CHANGE CLOCK FROM OPTIONAL
    
    // Clock
    var clockTime: Timer?
    var whichHalf: Int
    
    // Team 1 game stats
    var team1Score: Int
    var team1CompletionsMade: Int
    var team1CompletionsAttempted: Int
    var team1InterceptionsThrown: Int
    var team1FieldGoalsMade: Int
    var team1FieldGoalsAttempted: Int
    var team1PATsMade: Int
    var team1PATsAttempted: Int
    var team1Touchdowns: Int
    var team1TwoPointConversions: Int
    var team1InterceptionsCaught: Int
    
    // Team 2 game stats
    var team2Score: Int
    var team2CompletionsMade: Int
    var team2CompletionsAttempted: Int
    var team2InterceptionsThrown: Int
    var team2FieldGoalsMade: Int
    var team2FieldGoalsAttempted: Int
    var team2PATsMade: Int
    var team2PATsAttempted: Int
    var team2Touchdowns: Int
    var team2TwoPointConversions: Int
    var team2InterceptionsCaught: Int
    
    // CloudKit variables
    var leagueReference: CKRecord.Reference
    var ckRecordID: CKRecord.ID?

    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - KEYS
    
    static let gameTypeKey = "Game"
    
    // Game info
    fileprivate static let dateKey = "date"
    fileprivate static let team1Key = "team1"
    fileprivate static let team2Key = "team2"
    
    fileprivate static let team1NameKey = "team1Name"
    fileprivate static let team1CoachKey = "team1Coach"
    fileprivate static let team1ColorKey = "team1Color"
    fileprivate static let team1CKRecordIDKey = "team1CKRecordID"
    
    fileprivate static let team2NameKey = "team2Name"
    fileprivate static let team2CoachKey = "team2Coach"
    fileprivate static let team2ColorKey = "team2Color"
    fileprivate static let team2CKRecordIDKey = "team2CKRecordID"
    
    // Clock
    fileprivate static let clockTimeKey = "clockTime"
    fileprivate static let whichHalfKey = "whichHalf"
    
    // Team 1 game stats
    fileprivate static let team1ScoreKey = "team1Score"
    fileprivate static let team1CompletionsMadeKey = "team1CompletionsMade"
    fileprivate static let team1CompletionsAttemptedKey = "team1CompletionsAttempted"
    fileprivate static let team1InterceptionsThrownKey = "team1InterceptionsThrown"
    fileprivate static let team1FieldGoalsMadeKey = "team1FieldGoalsMade"
    fileprivate static let team1FieldGoalsAttemptedKey = "team1FieldGoalsAttempted"
    fileprivate static let team1PATsMadeKey = "team1PATsMade"
    fileprivate static let team1PATsAttemptedKey = "team1PATsAttempted"
    fileprivate static let team1TouchdownsKey = "team1Touchdowns"
    fileprivate static let team1TwoPointConversionsKey = "team1TwoPointConversions"
    fileprivate static let team1InterceptionsCaughtKey = "team1InterceptionsCaught"
    
    // Team 2 game stats
    fileprivate static let team2ScoreKey = "team2Score"
    fileprivate static let team2CompletionsMadeKey = "team2CompletionsMade"
    fileprivate static let team2CompletionsAttemptedKey = "team2CompletionsAttempted"
    fileprivate static let team2InterceptionsThrownKey = "team2InterceptionsThrown"
    fileprivate static let team2FieldGoalsMadeKey = "team2FieldGoalsMade"
    fileprivate static let team2FieldGoalsAttemptedKey = "team2FieldGoalsAttempted"
    fileprivate static let team2PATsMadeKey = "team2PATsMade"
    fileprivate static let team2PATsAttemptedKey = "team2PATsAttempted"
    fileprivate static let team2TouchdownsKey = "team2Touchdowns"
    fileprivate static let team2TwoPointConversionsKey = "team2TwoPointConversions"
    fileprivate static let team2InterceptionsCaughtKey = "team2InterceptionsCaught"
    
    // CloudKit variables
    fileprivate static let leagueReferenceKey = "leagueReference"
    
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - MEMBERWISE INITIALIZER
    
    init(
        
        // Game info
        team1: Team,
        team2: Team,
        
        // Clock
        clockTime: Timer = Timer(),
        whichHalf: Int = 0,
        
        // Team 1 game stats
        team1Score: Int = 0,
        team1CompletionsMade: Int = 0,
        team1CompletionsAttempted: Int = 0,
        team1InterceptionsThrown: Int = 0,
        team1FieldGoalsMade: Int = 0,
        team1FieldGoalsAttempted: Int = 0,
        team1PATsMade: Int = 0,
        team1PATsAttempted: Int = 0,
        team1Touchdowns: Int = 0,
        team1TwoPointConversions: Int = 0,
        team1InterceptionsCaught: Int = 0,
        
        // Team 2 game stats
        team2Score: Int = 0,
        team2CompletionsMade: Int = 0,
        team2CompletionsAttempted: Int = 0,
        team2InterceptionsThrown: Int = 0,
        team2FieldGoalsMade: Int = 0,
        team2FieldGoalsAttempted: Int = 0,
        team2PATsMade: Int = 0,
        team2PATsAttempted: Int = 0,
        team2Touchdowns: Int = 0,
        team2TwoPointConversions: Int = 0,
        team2InterceptionsCaught: Int = 0,
        
        // CloudKit variables
        leagueReference: CKRecord.Reference) {
        
        // Game info
        self.team1 = team1
        self.team2 = team2
        
        self.team1Name = team1.name
        self.team1Coach = team1.coach
        self.team1Color = team1.color.rawValue
        self.team1CKRecordID = team1.ckRecordID
        
        self.team2Name = team2.name
        self.team2Coach = team2.coach
        self.team2Color = team2.color.rawValue
        self.team2CKRecordID = team2.ckRecordID
        
        // Clock
        self.clockTime = clockTime
        self.whichHalf = whichHalf
        
        // Team 1 game stats
        self.team1Score = team1Score
        self.team1CompletionsMade = team1CompletionsMade
        self.team1CompletionsAttempted = team1CompletionsAttempted
        self.team1InterceptionsThrown = team1InterceptionsThrown
        self.team1FieldGoalsMade = team1FieldGoalsMade
        self.team1FieldGoalsAttempted = team1FieldGoalsAttempted
        self.team1PATsMade = team1PATsMade
        self.team1PATsAttempted = team1PATsAttempted
        self.team1Touchdowns = team1Touchdowns
        self.team1TwoPointConversions = team1TwoPointConversions
        self.team1InterceptionsCaught = team1InterceptionsCaught
        
        // Team 2 game stats
        self.team2Score = team2Score
        self.team2CompletionsMade = team2CompletionsMade
        self.team2CompletionsAttempted = team2CompletionsAttempted
        self.team2InterceptionsThrown = team2InterceptionsThrown
        self.team2FieldGoalsMade = team2FieldGoalsMade
        self.team2FieldGoalsAttempted = team2FieldGoalsAttempted
        self.team2PATsMade = team2PATsMade
        self.team2PATsAttempted = team2PATsAttempted
        self.team2Touchdowns = team2Touchdowns
        self.team2TwoPointConversions = team2TwoPointConversions
        self.team2InterceptionsCaught = team2InterceptionsCaught
        
        // CloudKit variables
        self.leagueReference = leagueReference
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - INITIALIZE MODEL OBJECT FROM CKRECORD
    
    init?(ckRecord: CKRecord) {
    
        // Unpack values
        
        // Game info
        guard let date = ckRecord[Game.dateKey] as? Date?,

// ❎ NEED TO REACTIVATE CLOCK, CHANGE IT FROM OPTIONAL ABOVE
            
            // Clock
            //            let clockTime = ckRecord[Game.clockTimeKey] as? Timer,
            let whichHalf = ckRecord[Game.whichHalfKey] as? Int,
            
            let team1Name = ckRecord[Game.team1NameKey] as? String,
            let team1Color = ckRecord[Game.team1ColorKey] as? String,
            let team1Coach = ckRecord[Game.team1CoachKey] as? String,
            let team1CKRecordID = ckRecord[Game.team1CKRecordIDKey] as? String,
            
            let team2Name = ckRecord[Game.team2NameKey] as? String,
            let team2Color = ckRecord[Game.team2ColorKey] as? String,
            let team2Coach = ckRecord[Game.team2CoachKey] as? String,
            let team2CKRecordID = ckRecord[Game.team2CKRecordIDKey] as? String,
            
            // Team 1 game stats
            let team1Score = ckRecord[Game.team1ScoreKey] as? Int,
            let team1CompletionsMade = ckRecord[Game.team1CompletionsMadeKey] as? Int,
            let team1CompletionsAttempted = ckRecord[Game.team1CompletionsAttemptedKey] as? Int,
            let team1InterceptionsThrown = ckRecord[Game.team1InterceptionsThrownKey] as? Int,
            let team1FieldGoalsMade = ckRecord[Game.team1FieldGoalsMadeKey] as? Int,
            let team1FieldGoalsAttempted = ckRecord[Game.team1FieldGoalsAttemptedKey] as? Int,
            let team1PATsMade = ckRecord[Game.team1PATsMadeKey] as? Int,
            let team1PATsAttempted = ckRecord[Game.team1PATsAttemptedKey] as? Int,
            let team1Touchdowns = ckRecord[Game.team1TouchdownsKey] as? Int,
            let team1TwoPointConversions = ckRecord[Game.team1TwoPointConversionsKey] as? Int,
            let team1InterceptionsCaught = ckRecord[Game.team1InterceptionsCaughtKey] as? Int,
        
            // Team 2 game stats
            let team2Score = ckRecord[Game.team2ScoreKey] as? Int,
            let team2CompletionsMade = ckRecord[Game.team2CompletionsMadeKey] as? Int,
            let team2CompletionsAttempted = ckRecord[Game.team2CompletionsAttemptedKey] as? Int,
            let team2InterceptionsThrown = ckRecord[Game.team2InterceptionsThrownKey] as? Int,
            let team2FieldGoalsMade = ckRecord[Game.team2FieldGoalsMadeKey] as? Int,
            let team2FieldGoalsAttempted = ckRecord[Game.team2FieldGoalsAttemptedKey] as? Int,
            let team2PATsMade = ckRecord[Game.team2PATsMadeKey] as? Int,
            let team2PATsAttempted = ckRecord[Game.team2PATsAttemptedKey] as? Int,
            let team2Touchdowns = ckRecord[Game.team2TouchdownsKey] as? Int,
            let team2TwoPointConversions = ckRecord[Game.team2TwoPointConversionsKey] as? Int,
            let team2InterceptionsCaught = ckRecord[Game.team2InterceptionsCaughtKey] as? Int,
        
            // CloudKit variables
            let leagueReference = ckRecord[Game.leagueReferenceKey] as? CKRecord.Reference
            
            else { return nil }
        
        // Set as values of new instance
        
        // Game info
        self.date = date
        
        // Clock

// ❎ NEED TO REACTIVATE CLOCK, CHANGE IT FROM OPTIONAL ABOVE
        
        //        self.clockTime = clockTime
        self.whichHalf = whichHalf
        
        self.team1Coach = team1Coach
        self.team1Name = team1Name
        self.team1Color = team1Color
        self.team1CKRecordID = CKRecord.ID(recordName: team1CKRecordID)
        
        self.team2Name = team2Name
        self.team2Coach = team2Coach
        self.team2Color = team2Color
        self.team2CKRecordID = CKRecord.ID(recordName: team2CKRecordID)
        
        // Team 1 game stats
        self.team1Score = team1Score
        self.team1CompletionsMade = team1CompletionsMade
        self.team1CompletionsAttempted = team1CompletionsAttempted
        self.team1InterceptionsThrown = team1InterceptionsThrown
        self.team1FieldGoalsMade = team1FieldGoalsMade
        self.team1FieldGoalsAttempted = team1FieldGoalsAttempted
        self.team1PATsMade = team1PATsMade
        self.team1PATsAttempted = team1PATsAttempted
        self.team1Touchdowns = team1Touchdowns
        self.team1TwoPointConversions = team1TwoPointConversions
        self.team1InterceptionsCaught = team1InterceptionsCaught
        
        // Team 2 game stats
        self.team2Score = team2Score
        self.team2CompletionsMade = team2CompletionsMade
        self.team2CompletionsAttempted = team2CompletionsAttempted
        self.team2InterceptionsThrown = team2InterceptionsThrown
        self.team2FieldGoalsMade = team2FieldGoalsMade
        self.team2FieldGoalsAttempted = team2FieldGoalsAttempted
        self.team2PATsMade = team2PATsMade
        self.team2PATsAttempted = team2PATsAttempted
        self.team2Touchdowns = team2Touchdowns
        self.team2TwoPointConversions = team2TwoPointConversions
        self.team2InterceptionsCaught = team2InterceptionsCaught
        
        // CloudKit variables
        self.leagueReference = leagueReference
        self.ckRecordID = ckRecord.recordID
    }
}

// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - INITIALIZE CKRECORD FROM MODEL OBJECT

extension CKRecord {
    
    convenience init(game: Game) {
        
        // Use existing ckRecordID or create new one and give it UUID (convert to string)
        let recordID = game.ckRecordID ?? CKRecord.ID(recordName: UUID().uuidString)
        
        // Now initialize ckRecordID as string version (recordID)
        self.init(recordType: Game.gameTypeKey, recordID: recordID)
        
        // Set CKRecord values
        
        // Game info
        if let date = game.date {
            self.setValue(date, forKey: Game.dateKey)
        }
        
        self.setValue(game.team1Name, forKey: Game.team1NameKey)
        self.setValue(game.team1Color, forKey: Game.team1ColorKey)
        self.setValue(game.team1Coach, forKey: Game.team1CoachKey)
        self.setValue(game.team1CKRecordID?.recordName, forKey: Game.team1CKRecordIDKey)
        
        self.setValue(game.team2Name, forKey: Game.team2NameKey)
        self.setValue(game.team2Color, forKey: Game.team2ColorKey)
        self.setValue(game.team2Coach, forKey: Game.team2CoachKey)
        self.setValue(game.team2CKRecordID?.recordName, forKey: Game.team2CKRecordIDKey)
        
        // Clock
        self.setValue(game.clockTime, forKey: Game.clockTimeKey)
        self.setValue(game.whichHalf, forKey: Game.whichHalfKey)
        
        // Team 1 game stats
        self.setValue(game.team1Score, forKey: Game.team1ScoreKey)
        self.setValue(game.team1CompletionsMade, forKey: Game.team1CompletionsMadeKey)
        self.setValue(game.team1CompletionsAttempted, forKey: Game.team1CompletionsAttemptedKey)
        self.setValue(game.team1InterceptionsThrown, forKey: Game.team1InterceptionsThrownKey)
        self.setValue(game.team1FieldGoalsMade, forKey: Game.team1FieldGoalsMadeKey)
        self.setValue(game.team1FieldGoalsAttempted, forKey: Game.team1FieldGoalsAttemptedKey)
        self.setValue(game.team1PATsMade, forKey: Game.team1PATsMadeKey)
        self.setValue(game.team1PATsAttempted, forKey: Game.team1PATsAttemptedKey)
        self.setValue(game.team1Touchdowns, forKey: Game.team1TouchdownsKey)
        self.setValue(game.team1TwoPointConversions, forKey: Game.team1TwoPointConversionsKey)
        self.setValue(game.team1InterceptionsCaught, forKey: Game.team1InterceptionsCaughtKey)
        
        // Team 2 game stats
        self.setValue(game.team2Score, forKey: Game.team2ScoreKey)
        self.setValue(game.team2CompletionsMade, forKey: Game.team2CompletionsMadeKey)
        self.setValue(game.team2CompletionsAttempted, forKey: Game.team2CompletionsAttemptedKey)
        self.setValue(game.team2InterceptionsThrown, forKey: Game.team2InterceptionsThrownKey)
        self.setValue(game.team2FieldGoalsMade, forKey: Game.team2FieldGoalsMadeKey)
        self.setValue(game.team2FieldGoalsAttempted, forKey: Game.team2FieldGoalsAttemptedKey)
        self.setValue(game.team2PATsMade, forKey: Game.team2PATsMadeKey)
        self.setValue(game.team2PATsAttempted, forKey: Game.team2PATsAttemptedKey)
        self.setValue(game.team2Touchdowns, forKey: Game.team2TouchdownsKey)
        self.setValue(game.team2TwoPointConversions, forKey: Game.team2TwoPointConversionsKey)
        self.setValue(game.team2InterceptionsCaught, forKey: Game.team2InterceptionsCaughtKey)
        
        // CloudKit variables
        self.setValue(game.leagueReference, forKey: Game.leagueReferenceKey)
        
        // Give new record ckRecord new ID (or pass along existing)
        game.ckRecordID = recordID
    }
}
// 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
// 🔸 MARK: - EQUATABLE EXTENSION

extension Game: Equatable {
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}
