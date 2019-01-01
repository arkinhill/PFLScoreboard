//
//  GameController.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/20/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import Foundation
import CloudKit

class GameController {
 
    // MARK: - SHARED, SOURCE, DATABASE
    
    // Shared instance
    static let shared = GameController()
    
    // Source of truth
    var games: [Game] = []
    
    // Database
    private let database = CKContainer.default().publicCloudDatabase
    
    // MARK: - CRUD FUNCTIONS
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - CREATE
    
    func createGame(
        
        // Game info
        date: Date = Date(),
        team1: Team,
        team2: Team,
        league: League,
        
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
        
        completion: @escaping (Bool) -> Void = { _ in }) {
        
        // Make sure correct user is creating array
        guard let leagueRecordID = league.ckRecordID else {
            completion(false)
            return
        }
        let leagueReference = CKRecord.Reference(recordID: leagueRecordID, action: .deleteSelf)
        
        // Append source of truth, call completion
        let game = Game(
            
            // Game info
            date: date,
            team1: team1,
            team2: team2,
            
            // Clock
            clockTime: clockTime,
            whichHalf: whichHalf,
            
            // Team 1 game stats
            team1Score: team1Score,
            team1CompletionsMade: team1CompletionsMade,
            team1CompletionsAttempted: team1CompletionsAttempted,
            team1InterceptionsThrown: team1InterceptionsThrown,
            team1FieldGoalsMade: team1FieldGoalsMade,
            team1FieldGoalsAttempted: team1FieldGoalsAttempted,
            team1PATsMade: team1PATsMade,
            team1PATsAttempted: team1PATsAttempted,
            team1Touchdowns: team1Touchdowns,
            team1TwoPointConversions: team1TwoPointConversions,
            team1InterceptionsCaught: team1InterceptionsCaught,
            
            // Team 2 game stats
            team2Score: team2Score,
            team2CompletionsMade: team2CompletionsMade,
            team2CompletionsAttempted: team2CompletionsAttempted,
            team2InterceptionsThrown: team2InterceptionsThrown,
            team2FieldGoalsMade: team2FieldGoalsMade,
            team2FieldGoalsAttempted: team2FieldGoalsAttempted,
            team2PATsMade: team2PATsMade,
            team2PATsAttempted: team2PATsAttempted,
            team2Touchdowns: team2Touchdowns,
            team2TwoPointConversions: team2TwoPointConversions,
            team2InterceptionsCaught: team2InterceptionsCaught,
            
            // CloudKit variables
            leagueReference: leagueReference
        )
        
        league.games.append(game)
        saveGame(game: game) { (success) in
            completion(true)
        }
    }
    
    func saveGame(game: Game, completion: @escaping (Bool) -> Void) {
        
        // Save record, check to see if worked, handle error
        let record = CKRecord(game: game)
        database.save(record) { (ckRecord, error) in
            if let error = error {
                print("Error saving game record: \(error.localizedDescription)")
                completion(false)
                return
            }
            // Append source of truth, call completion
            completion(true)
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - READ
    
    func fetchGamesFor(league: League, completion: @escaping (Bool) -> Void) {
        
        // Set predicate to user reference, so we can pull users games from database in query
        guard let leagueRecordID = league.ckRecordID else {
            completion(false)
            return
        }
        
        let predicate = NSPredicate(format: "leagueReference == %@", leagueRecordID)
        let query = CKQuery(recordType: "Game", predicate: predicate)
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching game records: \(error.localizedDescription)")
                completion(false)
                return
            }
            // Make sure we have records
            guard let records = records else {
                completion(false)
                return
            }
            // Gather games into array, replace source of truth with new array, call completion
            let fetchedGames = records.compactMap { Game(ckRecord: $0) }
            league.games = fetchedGames
            completion(true)
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - UPDATE
    
    func updateGame(
        
        game: Game,
        
        // Game info
        date: Date,
        team1: Team,
        team2: Team,
        
        // Clock
        clockTime: Timer,
        whichHalf: Int,
        
        // Team 1 game stats
        team1Score: Int,
        team1CompletionsMade: Int,
        team1CompletionsAttempted: Int,
        team1InterceptionsThrown: Int,
        team1FieldGoalsMade: Int,
        team1FieldGoalsAttempted: Int,
        team1PATsMade: Int,
        team1PATsAttempted: Int,
        team1Touchdowns: Int,
        team1TwoPointConversions: Int,
        team1InterceptionsCaught: Int,
        
        // Team 2 game stats
        team2Score: Int,
        team2CompletionsMade: Int,
        team2CompletionsAttempted: Int,
        team2InterceptionsThrown: Int,
        team2FieldGoalsMade: Int,
        team2FieldGoalsAttempted: Int,
        team2PATsMade: Int,
        team2PATsAttempted: Int,
        team2Touchdowns: Int,
        team2TwoPointConversions: Int,
        team2InterceptionsCaught: Int,
        
        completion: @escaping (Bool) -> Void) {
        
        // Take existing game, update it locally
        
        // Game info
        game.date = date
        game.team1 = team1
        game.team2 = team2
        
        // Clock
        game.clockTime = clockTime
        game.whichHalf = whichHalf
        
        // Team 1 game stats
        game.team1Score = team1Score
        game.team1CompletionsMade = team1CompletionsMade
        game.team1CompletionsAttempted = team1CompletionsAttempted
        game.team1InterceptionsThrown = team1InterceptionsThrown
        game.team1FieldGoalsMade = team1FieldGoalsMade
        game.team1FieldGoalsAttempted = team1FieldGoalsAttempted
        game.team1PATsMade = team1PATsMade
        game.team1PATsAttempted = team1PATsAttempted
        game.team1Touchdowns = team1Touchdowns
        game.team1TwoPointConversions = team1TwoPointConversions
        game.team1InterceptionsCaught = team1InterceptionsCaught
        
        // Team 2 game stats
        game.team2Score = team2Score
        game.team2CompletionsMade = team2CompletionsMade
        game.team2CompletionsAttempted = team2CompletionsAttempted
        game.team2InterceptionsThrown = team2InterceptionsThrown
        game.team2FieldGoalsMade = team2FieldGoalsMade
        game.team2FieldGoalsAttempted = team2FieldGoalsAttempted
        game.team2PATsMade = team2PATsMade
        game.team2PATsAttempted = team2PATsAttempted
        game.team2Touchdowns = team2Touchdowns
        game.team2TwoPointConversions = team2TwoPointConversions
        game.team2InterceptionsCaught = team2InterceptionsCaught
        
        // Take new game, update fields that have changed
        let record = CKRecord(game: game)
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        
        // Update team on CloudKit
        operation.completionBlock = {
            completion(true)
        }
        database.add(operation)
    }
}
