//
//  Game.swift
//  BubblePopOut
//
//  Created by  on 25/04/2024.
//

import Foundation

struct ScoreEntry {
    let username: String
    let score: Double
}



class Game: NSObject {
    
    static let shared = Game() // Singleton instance
    
    public var score: Double = 0
    public var maxBubbles = 15
    public var remainTime = 60
    public var selectedTime = 60
    public var playerName = ""
    public var ranking: [ScoreEntry] = []
    
    public var rankingDictionary = [String : Double]()
    public var sortedHighScoreArray = [(key: String, value: Double)]()
    public var previousRankingDictionary: [String : Double]? = [String : Double]()
    
    
    private override init() {
        super.init()
        loadHighScores()
    } // Private initializer to prevent instantiation
    
    func reset(){
        self.score = 0
        self.remainTime = selectedTime
        self.playerName = ""
    }
    
    private func loadHighScores() {
        if let savedScores = UserDefaults.standard.dictionary(forKey: "ranking") as? [String : Double] {
            rankingDictionary = savedScores
            previousRankingDictionary = savedScores
            updateRankingArray()
        }
    }
    
    private func updateRankingArray() {
        sortedHighScoreArray = rankingDictionary.sorted(by: { $0.value > $1.value })
        ranking = sortedHighScoreArray.map {
            ScoreEntry(username: $0.key, score: $0.value)
        }
    }
    
    func saveHighScore() {
        let oldScore = rankingDictionary[playerName] ?? 0
        
        if score > oldScore {
            rankingDictionary[playerName] = score
            previousRankingDictionary = rankingDictionary
            UserDefaults.standard.set(rankingDictionary, forKey: "ranking")
            updateRankingArray()
        }
    }
    
    func checkHighScoreExistence() {
        saveHighScore()
    }
    
    func getHighestScorer() -> ScoreEntry? {
        return ranking.first
    }
}
