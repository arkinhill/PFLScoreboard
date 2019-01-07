//
//  TeamController.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/20/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import Foundation
import CloudKit

class TeamController {
   
    // MARK: - SHARED, DATABASE
    
    // Shared instance
    static let shared = TeamController()
    
    // Database
    private let database = CKContainer.default().publicCloudDatabase
    
    // MARK: - CRUD FUNCTIONS
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - CREATE
    
    func createTeam(
        coach: String,
        name: String,
        color: Team.Color,
        league: League,
        
        completion: @escaping (Team?) -> Void) {
        
        // Make sure correct user is creating array
        guard let leagueCKRecord = league.ckRecordID else {
            completion(nil)
            return
        }
        
        let leagueReference = CKRecord.Reference(recordID: leagueCKRecord, action: .deleteSelf)
        
        // Append source of truth, call completion
        let team = Team(coach: coach, name: name, color: color, leagueReference: leagueReference)
            saveTeam(team: team) { (success) in
            completion(team)
        }
    }
    
    func saveTeam(team: Team, completion: @escaping (Bool) -> Void) {
        
        // Save record, check to see if worked, handle error
        let record = CKRecord(team: team)
        database.save(record) { (ckRecord, error) in
            if let error = error {
                print("Error saving team record: \(error.localizedDescription)")
                completion(false)
                return
            }
            // Append source of truth, call completion
            completion(true)
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - READ
    
    func fetchTeamsFor(league: League, completion: @escaping (Bool) -> Void) {
        
        // Set predicate to user reference, so we can pull users teams from database in query
        guard let leagueCKRecord = league.ckRecordID else {
            completion(false)
            return
        }
        let predicate = NSPredicate(format: "leagueReference == %@", leagueCKRecord)
        let query = CKQuery(recordType: "Team", predicate: predicate)
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching team records: \(error.localizedDescription)")
                completion(false)
                return
            }
            // Make sure we have records
            guard let records = records else {
                completion(false)
                return
            }
            // Gather teams into array, replace source of truth with new array, call completion
            let fetchedTeams = records.compactMap { Team(ckRecord: $0) }
            league.teams = fetchedTeams
            completion(true)
        }
    }
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - UPDATE
    
    func updateTeam(
        
        team: Team,
        
        // General team info
        coach: String,
        name: String,
        color: Team.Color,
        
        // Team record
        wins: Int,
        losses: Int,
        rank: Int,
        
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
        
        completion: @escaping (Bool) -> Void) {
        
        // Take existing team, update it locally
        
        // General team info
        team.coach = coach
        team.name = name
        team.color = color
        
        // Team record
        team.wins = wins
        team.losses = losses
        team.rank = rank
        
        // Team stats
        team.completionsAttempted = completionsAttempted
        team.completionsMade = completionsMade
        team.interceptionsThrown = interceptionsThrown
        team.fieldGoalsMade = fieldGoalsMade
        team.fieldGoalsAttempted = fieldGoalsAttempted
        team.pATsMade = pATsMade
        team.pATsAttempted = pATsAttempted
        team.touchdowns = touchdowns
        team.twoPointConversions = twoPointConversions
        team.interceptionsCaught = interceptionsCaught
        
        // Take new team, update fields that have changed
        let record = CKRecord(team: team)
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
