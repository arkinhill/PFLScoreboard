//
//  LeagueController.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/20/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import Foundation
import CloudKit

class LeagueController {
    
    // MARK: - SHARED, SOURCE, DATABASE
    
    // Shared instance
    static let shared = LeagueController()
    
    // Source of truth ??
    var leagues: [League] = []
    
    // Database
    private let database = CKContainer.default().publicCloudDatabase
    
    // MARK: - CRUD FUNCTIONS
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - CREATE LEAGUE
    
    func createLeague(leagueName: String, isPending: Bool, users: [User], completion: @escaping (League?) -> Void) {
        
        // Make sure correct user is creating array
        guard let appleUserReference = UserController.shared.loggedInUser?.appleUserReference else {
            completion(nil)
            return
        }
        // Append source of truth, call completion
        let league = League(leagueName: leagueName, userReference: appleUserReference)
//        let league = League(leagueName: leagueName, isPending: isPending, users: users, userReference: CKRecord.Reference)
        saveLeague(league: league) { (success) in }
            completion(league)
    }

    func saveLeague(league: League, completion: @escaping (Bool) -> Void) {
        
        // Save record, check to see if worked, handle error
        let record = CKRecord(league: league)
        database.save(record) { (ckRecord, error) in
            if let error = error {
                print("Error saving league record: \(error.localizedDescription)")
                completion(false)
                return
            }
            // Append source of truth, call completion
            self.leagues.append(league)
            completion(true)
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ADD TEAMS TO LEAGUE
    
    func addTeamToLeague(league: League, team: Team, completion: @escaping (Bool) -> Void) {
        league.teams.append(team)
        saveLeague(league: league, completion: <#T##(Bool) -> Void#>)
    }

    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - ADD GAMES TO LEAGUE
    
    // Game schedule for a league of 4 teams (each team plays other team twice = 12 games)
    func addGamesTo4TeamLeague(league: League) {
        
        let teamA = league.teams[0]
        let teamB = league.teams[1]
        let teamC = league.teams[2]
        let teamD = league.teams[3]
        
        // Game 1
        GameController.shared.createGame(team1: teamA, team2: teamC, league: league)
        // Game 2
        GameController.shared.createGame(team1: teamB, team2: teamA, league: league)
        // Game 3
        GameController.shared.createGame(team1: teamC, team2: teamD, league: league)
        // Game 4
        GameController.shared.createGame(team1: teamD, team2: teamB, league: league)
        // Game 5
        GameController.shared.createGame(team1: teamC, team2: teamD, league: league)
        // Game 6
        GameController.shared.createGame(team1: teamA, team2: teamB, league: league)
        // Game 7
        GameController.shared.createGame(team1: teamC, team2: teamA, league: league)
        // Game 8
        GameController.shared.createGame(team1: teamD, team2: teamA, league: league)
        // Game 9
        GameController.shared.createGame(team1: teamB, team2: teamD, league: league)
        // Game 10
        GameController.shared.createGame(team1: teamC, team2: teamB, league: league)
        // Game 11
        GameController.shared.createGame(team1: teamA, team2: teamD, league: league)
        // Game 12
        GameController.shared.createGame(team1: teamB, team2: teamC, league: league)
    }
    
    // Game schedule for a league of 6 teams (each team plays other team once = 15 games)
    func addGamesTo6TeamLeague(league: League) {
        
        let teamA = league.teams[0]
        let teamB = league.teams[1]
        let teamC = league.teams[2]
        let teamD = league.teams[3]
        let teamE = league.teams[4]
        let teamF = league.teams[5]
        
        // Game 1
        GameController.shared.createGame(team1: teamE, team2: teamF, league: league)
        // Game 2
        GameController.shared.createGame(team1: teamC, team2: teamE, league: league)
        // Game 3
        GameController.shared.createGame(team1: teamF, team2: teamC, league: league)
        // Game 4
        GameController.shared.createGame(team1: teamA, team2: teamE, league: league)
        // Game 5
        GameController.shared.createGame(team1: teamD, team2: teamA, league: league)
        // Game 6
        GameController.shared.createGame(team1: teamA, team2: teamF, league: league)
        // Game 7
        GameController.shared.createGame(team1: teamC, team2: teamD, league: league)
        // Game 8
        GameController.shared.createGame(team1: teamD, team2: teamF, league: league)
        // Game 9
        GameController.shared.createGame(team1: teamA, team2: teamC, league: league)
        // Game 10
        GameController.shared.createGame(team1: teamC, team2: teamB, league: league)
        // Game 11
        GameController.shared.createGame(team1: teamB, team2: teamF, league: league)
        // Game 12
        GameController.shared.createGame(team1: teamD, team2: teamB, league: league)
        // Game 13
        GameController.shared.createGame(team1: teamE, team2: teamD, league: league)
        // Game 14
        GameController.shared.createGame(team1: teamA, team2: teamB, league: league)
        // Game 15
        GameController.shared.createGame(team1: teamB, team2: teamE, league: league)
    }
    
    // Game schedule for a league of 8 teams (each team plays other team once = 28 games)
    func addGamesTo8TeamLeague(league: League) {
        
        let teamA = league.teams[0]
        let teamB = league.teams[1]
        let teamC = league.teams[2]
        let teamD = league.teams[3]
        let teamE = league.teams[4]
        let teamF = league.teams[5]
        let teamG = league.teams[6]
        let teamH = league.teams[7]
        
        // Game 1
        GameController.shared.createGame(team1: teamF, team2: teamH, league: league)
        // Game 2
        GameController.shared.createGame(team1: teamC, team2: teamD, league: league)
        // Game 3
        GameController.shared.createGame(team1: teamA, team2: teamF, league: league)
        // Game 4
        GameController.shared.createGame(team1: teamB, team2: teamA, league: league)
        // Game 5
        GameController.shared.createGame(team1: teamG, team2: teamC, league: league)
        // Game 6
        GameController.shared.createGame(team1: teamD, team2: teamA, league: league)
        // Game 7
        GameController.shared.createGame(team1: teamE, team2: teamD, league: league)
        // Game 8
        GameController.shared.createGame(team1: teamC, team2: teamE, league: league)
        // Game 9
        GameController.shared.createGame(team1: teamA, team2: teamH, league: league)
        // Game 10
        GameController.shared.createGame(team1: teamE, team2: teamG, league: league)
        // Game 11
        GameController.shared.createGame(team1: teamF, team2: teamB, league: league)
        // Game 12
        GameController.shared.createGame(team1: teamE, team2: teamF, league: league)
        // Game 13
        GameController.shared.createGame(team1: teamH, team2: teamC, league: league)
        // Game 14
        GameController.shared.createGame(team1: teamB, team2: teamG, league: league)
        // Game 15
        GameController.shared.createGame(team1: teamG, team2: teamF, league: league)
        // Game 16
        GameController.shared.createGame(team1: teamD, team2: teamB, league: league)
        // Game 17
        GameController.shared.createGame(team1: teamF, team2: teamC, league: league)
        // Game 18
        GameController.shared.createGame(team1: teamH, team2: teamG, league: league)
        // Game 19
        GameController.shared.createGame(team1: teamE, team2: teamH, league: league)
        // Game 20
        GameController.shared.createGame(team1: teamD, team2: teamF, league: league)
        // Game 21
        GameController.shared.createGame(team1: teamB, team2: teamH, league: league)
        // Game 22
        GameController.shared.createGame(team1: teamA, team2: teamE, league: league)
        // Game 23
        GameController.shared.createGame(team1: teamG, team2: teamD, league: league)
        // Game 24
        GameController.shared.createGame(team1: teamE, team2: teamB, league: league)
        // Game 25
        GameController.shared.createGame(team1: teamC, team2: teamB, league: league)
        // Game 26
        GameController.shared.createGame(team1: teamH, team2: teamD, league: league)
        // Game 27
        GameController.shared.createGame(team1: teamA, team2: teamC, league: league)
        // Game 28
        GameController.shared.createGame(team1: teamG, team2: teamA, league: league)
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - READ
    
    func fetchLeagues(completion: @escaping (Bool) -> Void) {
        
        // Set predicate to user reference, so we can pull users leagues from database in query
        guard let appleUserReference = UserController.shared.loggedInUser?.appleUserReference else {
            completion(false)
            return
        }
        let predicate = NSPredicate(format: "appleUser == %@", appleUserReference)
        let query = CKQuery(recordType: "League", predicate: predicate)
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching league records: \(error.localizedDescription)")
                completion(false)
                return
            }
            // Make sure we have records
            guard let records = records else {
                completion(false)
                return
            }
            // Gather leagues into array, replace source of truth with new array, call completion
            let fetchedLeagues = records.compactMap { League(ckRecord: $0) }
            self.leagues = fetchedLeagues
            completion(true)
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - UPDATE
    
    func updateLeague(league: League, leagueName: String, isPending: Bool, teams: [Team], users: [User], completion: @escaping (Bool) -> Void) {
        
        // Take existing league, update it locally
        league.leagueName = leagueName
        league.isPending = isPending
        league.teams = teams
        league.users = users
        
        // Take new league, update fields that have changed
        let record = CKRecord(league: league)
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        
        // Update league on CloudKit
        operation.completionBlock = {
            completion(true)
        }
        database.add(operation)
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - DELETE 
    
    func deleteLeague(league: League, completion: @escaping (Bool) -> Void) {
        
        // Unwrap
        guard let recordID = league.ckRecordID else {
            completion(false)
            return
        }
        // Delete object from CloudKit
        database.delete(withRecordID: recordID) { (ckRecord, error) in
            if let error = error {
                print("Error deleting league: \(error.localizedDescription)")
                completion(false)
                return
            }
            // Call completion
            completion(true)
        }
        // Remove league from source of truth (don't want this in async cell)
        guard let index = self.leagues.index(of: league) else { return }
        self.leagues.remove(at: index)
    }
}

