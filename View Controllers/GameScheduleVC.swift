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
        
// ❎ I DON'T KNOW IF THIS IS THE RIGHT LOCATION FOR GAMES ARRAY
        GameController.shared.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCVCell else { return UICollectionViewCell() }
        
// ❎ I DON'T KNOW IF THIS IS THE RIGHT LOCATION FOR GAMES ARRAY
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
    }
    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    }
}
