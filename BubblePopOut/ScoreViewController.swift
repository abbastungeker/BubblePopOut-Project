//
//  ScoreViewController.swift
//  BubblePopOut
//
//  Created  on 25/04/2024.
//

import UIKit

class ScoreViewController: UIViewController {
    

   
    @IBOutlet weak var scoreTableView: UITableView!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scoreTableView.delegate = self
        self.scoreTableView.dataSource = self
        
        loadScores()
        self.scoreTableView.reloadData()
        
        if let highestScorer = Game.shared.getHighestScorer() {
            self.highScoreLabel.text = "\(highestScorer.score)"
            print("The highest scorer is \(highestScorer.username) with a score of \(highestScorer.score)")
        } else {
            print("No scores available.")
            self.highScoreLabel.text = "--"
        }
    }
    
    
    func loadScores() {
        if let savedRanking = UserDefaults.standard.dictionary(forKey: "ranking") as? [String : Double] {
            let sortedRanking = savedRanking.sorted(by: { $0.value > $1.value })
            Game.shared.ranking = sortedRanking.map {
                ScoreEntry(username: $0.key, score: $0.value)
            }
        }
    }


}

extension ScoreViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.ranking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableViewCell", for: indexPath) as! ScoreTableViewCell
        
        // Configure the cell
        let entry = Game.shared.ranking[indexPath.row]
        
        cell.playerNameLabel.text = entry.username
        cell.playerScoreLabel.text = String(entry.score)
        
        return cell
    }
    
    
}
