//
//  UserController.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    // MARK: - SHARED, SOURCE, DATABASE
    
    // Shared instance
    static let shared = UserController()
    
    // Source of truth
    var loggedInUser: User?
    var appleUserRecordID: CKRecord.ID?
    
    // Database
    let database = CKContainer.default().publicCloudDatabase
    
    // MARK: - FETCH USER FUNCTION
    
    func fetchLoggedInUser(completion: @escaping (Bool) -> Void) {
        
        // Check to see if logged in user already has Apple user reference
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                print("Error getting user recordID: \(error.localizedDescription)")
                completion(false)
                return
            }
            // Unwrap record ID, set to source of truth
            guard let recordID = recordID else { completion(false) ; return }
            self.appleUserRecordID = recordID
            
            // Now search in database for user with CKReference to this CKRecordID
            let predicate = NSPredicate(format: "appleUser == %@", recordID)
            let query = CKQuery(recordType: User.userTypeKey, predicate: predicate)
            self.database.perform(query, inZoneWith: nil) { (records, error) in
                if let error = error {
                    print("Error fetching user object: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                // Unwrap record, assign to source of truth
                guard let records = records,
                    let userRecord = records.first else {completion(false) ; return }
                
                let loggedInUser = User(ckRecord: userRecord)
                self.loggedInUser = loggedInUser
                completion(true)
            }
        }
    }
    
    // MARK: - CREATE USER FUNCTION
    
    func createUser(username: String, completion: @escaping (Bool) -> Void) {
        
        // Unwrap Apple user reference
        guard let appleUserRecordID = appleUserRecordID else { completion(false) ; return }
        let appleUserReference = CKRecord.Reference(recordID: appleUserRecordID, action: .deleteSelf)
        
        // Create new user
        let newUser = User(username: username, leagues: leagues, leagueInvites: leagueInvites, appleUserReference: appleUserReference)
        
        // Create record
        let userRecord = CKRecord(user: newUser)
        
        // Save CKRecord to database (remote)
        database.save(userRecord) { (_, error) in
            if let error = error {
                print("Error saving user to the database: \(error.localizedDescription)")
                completion(false)
                return
            }
            // Replace source of truth (local), and call source of truth
            self.loggedInUser = newUser
            completion(true)
        }
    }
}
