//
//  ViewController.swift
//  BubblePopOut
//
//  Created  on 25/04/2024.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!

    
    var stopWatch: Timer?
    var bubble = Bubble()
    var bubbleArray = [Bubble]()
    var highrscore: Double = 0.0
    
    var lastBubbleValue: Double = 0

    var screenWidth: UInt32 {
        return UInt32(UIScreen.main.bounds.width)
    }
    var screenHeight: UInt32 {
        return UInt32(UIScreen.main.bounds.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeRemaining.text = "\(Game.shared.remainTime)"
        currentScore.text = "\(Game.shared.score)"
        
        stopWatch = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.updateTime()
            if Game.shared.remainTime > 0 {
                self.removeBubble()
                self.makeBubbleView()
            }
        }
       
        
        if let highestScorer = Game.shared.getHighestScorer() {
            self.highScoreLabel.text = "\(highestScorer.score)"
            self.highrscore = highestScorer.score
            print("The highest scorer is \(highestScorer.username) with a score of \(highestScorer.score)")
        } else {
            print("No scores available.")
            self.highScoreLabel.text = "--"
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stopWatch?.invalidate()
        stopWatch = nil
        Game.shared.reset()
    }
    
    @IBAction func bubbleTapped(_ sender: Bubble) {
        
        sender.removeFromSuperview()
        
        // The bubble also needs to be removed from the array, not only the screen.
        if let bubbleIndex = bubbleArray.firstIndex(where: { $0 === sender }) {
            bubbleArray.remove(at: bubbleIndex)
        }
        
        if lastBubbleValue == sender.value {
            Game.shared.score += sender.value * 1.5
        }
        else {
            Game.shared.score += sender.value
        }
        lastBubbleValue = sender.value
        currentScore.text = "\(Game.shared.score)"
        
        
        if self.highrscore > Game.shared.score {
            highScoreLabel.text = "\(self.highrscore)"
        }else{
            highScoreLabel.text = "\(Game.shared.score)"
        }
    }
    
    func isOverlapped(bubbleToCreate: Bubble) -> Bool {
        for currentBubbles in bubbleArray {
            if bubbleToCreate.frame.intersects(currentBubbles.frame) {
                return true
            }
        }
        return false
    }
    
    @objc func makeBubbleView() {
        let availableSpaces = Game.shared.maxBubbles - bubbleArray.count
        
        if availableSpaces <= 0 {
            return
        }
        
        let numberToCreate = Int(arc4random_uniform(UInt32(availableSpaces))) + 1
        var numberCreated = 0
        var attempts = 0
        let maximumAttempts = numberToCreate * 20
        
        while numberCreated < numberToCreate && attempts < maximumAttempts {
            attempts += 1
            bubble = Bubble()
            bubble.frame = CGRect(x: CGFloat(10 + arc4random_uniform(screenWidth - 2 * bubble.radius - 20)), y: CGFloat(160 + arc4random_uniform(screenHeight - 2 * bubble.radius - 180)), width: CGFloat(2 * bubble.radius), height: CGFloat(2 * bubble.radius))
            
            if !isOverlapped(bubbleToCreate: bubble) {
                bubble.addTarget(self, action: #selector(bubbleTapped), for: UIControl.Event.touchUpInside)
                self.view.addSubview(bubble)
                bubble.animation()
                numberCreated += 1
                bubbleArray += [bubble]
            }
        }
    }
    
    @objc func removeBubble() {
        if bubbleArray.isEmpty {
            return
        }
        
        // Going backwards stops the next bubble being skipped after a removal.
        for i in stride(from: bubbleArray.count - 1, through: 0, by: -1) {
            if arc4random_uniform(100) < 33 {
                bubbleArray[i].removeFromSuperview()
                bubbleArray.remove(at: i)
            }
        }
    }
    
    @objc func updateTime() {
        if Game.shared.remainTime > 0 {
            Game.shared.remainTime -= 1
            timeRemaining.text = "\(Game.shared.remainTime)"
        }
        
        if Game.shared.remainTime == 0 {
            stopWatch?.invalidate()
            stopWatch = nil
            Game.shared.checkHighScoreExistence()
            
            let shownHighScore = max(highrscore, Game.shared.score)
            highScoreLabel.text = "\(shownHighScore)"
            
            // Present alert
            let alert = UIAlertController(title: "Time's Up!", message: "Current Score = \(Game.shared.score) \n High Score = \(shownHighScore)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                // Dismiss the current view controller
                Game.shared.reset()
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
