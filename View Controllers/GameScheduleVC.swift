//
//  GameScheduleVC.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/31/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import UIKit

class GameScheduleVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - LANDING PAD
    
    var league: League?
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - COLLECTION VIEW DATA SOURCE
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
// ❎ What is the right location for games array?
        
        return GameController.shared.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCVCell else { return UICollectionViewCell() }
        
// ❎ What is the right location for games array?
        
        let game = GameController.shared.games[indexPath.row]
        
        // Configure cell
        cell.leftHelmetImageView.image = UIImage(named: "helmet\(game.team1.color)Left")
        cell.leftHelmetLetterImageView.image = UIImage(named: "letter\(game.team1.name.prefix(1))")
        cell.rightHelmetImageView.image = UIImage(named: "helmet\(game.team2.color)Right")
        cell.rightHelmetLetterImageView.image = UIImage(named: "letter\(game.team1.name.prefix(1))")
        cell.team1NameLabel.text = game.team1.name.capitalized
        cell.team1ScoreLabel.text = "\(game.team1Score)"
        cell.team2NameLabel.text = game.team2.name.capitalized
        cell.team2ScoreLabel.text = "\(game.team2Score)"
        cell.gameDateLabel.text = "\(game.date)"
        
        return cell
    }
    
// ❎ Need to complete navigation (after user profile, and game schedule are working)
    
    // MARK: - NAVIGATION

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScoreboard" {
            guard let destinationVC = segue.destination as? ScoreboardVC, let indexPath = collectionView.indexPath(for: <#T##UICollectionViewCell#>) else { return }
            
            let game = GameController.shared.games[indexPath.row]
            destinationVC.selectedGame = game
        }
    }
}
