//
//  LeagueInvitedTVCell.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/20/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit

class LeagueInvitedTVCell: UITableViewCell {
    
    // MARK: - SET DELEGATE
    
    // Set delegate to protocol in child
    // (Step 2 of 5 - 3 steps in child (this file), 2 in parent)
    
    weak var delegate: LeagueInvitedTVCellDelegate?

    // MARK: - OUTLETS
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    // MARK: - ACTIONS
    
    @IBAction func acceptInviteButtonTapped(_ sender: Any) {
        
        // Call the delegate function
        // (Step 3 of 5 - 3 steps in child (this file), 2 in parent)
        
        delegate?.acceptInviteButtonTapped(self)
    }
    
    @IBAction func rejectInviteButtonTapped(_ sender: Any) {
        
        // Call the delegate function
        // (Step 3 of 5 - 3 steps in child (this file), 2 in parent)
        
        delegate?.rejectInviteButtonTapped(self)
    }
}

// MARK: - CUSTOM PROTOCOL FOR DELEGATE

// Create custom protocol for delegate so we can collect data in custom view and pass it to view controller
// (Step 1 of 5 - 3 steps in child (this file), 2 in parent)

protocol LeagueInvitedTVCellDelegate: class {
    func acceptInviteButtonTapped(_ sender: LeagueInvitedTVCell)
    func rejectInviteButtonTapped(_ sender: LeagueInvitedTVCell)
}

