//
//  GameCVCell.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/31/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit

class GameCVCell: UICollectionViewCell {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var leftHelmetImageView: UIImageView!
    @IBOutlet weak var leftHelmetLetterImageView: UIImageView!
    @IBOutlet weak var rightHelmetImageView: UIImageView!
    @IBOutlet weak var rightHelmetLetterImageView: UIImageView!
    @IBOutlet weak var team1NameLabel: UILabel!
    @IBOutlet weak var team1ScoreLabel: UILabel!
    @IBOutlet weak var team2NameLabel: UILabel!
    @IBOutlet weak var team2ScoreLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    
}
