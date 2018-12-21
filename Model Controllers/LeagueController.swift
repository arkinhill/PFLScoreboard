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
    
    // Source of truth
    var leagues: [League] = []
    
    // Database
    private let database = CKContainer.default().publicCloudDatabase
    
    // MARK: - CRUD FUNCTIONS
    
    // 🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸
    // 🔸 MARK: - CREATE
    
    func createLeague(leagueName: String, isPending: Bool, teams: [Team], users: [User], completion: @escaping (Bool) -> Void) {
        
        // Make sure correct user is creating array
        guard let appleUserReference = UserController.shared.loggedInUser?.appleUserReference else {
            completion(false)
            return
        }
        // Append source of truth, call completion
        let league = League(leagueName: leagueName, isPending: isPending, teams: teams, users: users, appleUserReference: appleUserReference)
        saveLeague(league: league) { (success) in }
            completion(true)
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
    
//❎ WE DON'T WANT TO DELETE A LEAGUE, JUST UNLINK IT FROM USER BEING ABLE TO SEE IT
    
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

