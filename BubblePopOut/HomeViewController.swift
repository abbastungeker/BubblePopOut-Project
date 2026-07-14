//
//  HomeViewController.swift
//  BubblePopOut
//
//  Created on 25/04/2024.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func gameAction(_ sender: Any) {
        
        // Create alert controller
        let alertController = UIAlertController(title: "Enter Your Name", message: nil, preferredStyle: .alert)
        
        // Add text field
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        // Add OK action
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let name = alertController.textFields?.first?.text {
                let cleanedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if cleanedName.isEmpty {
                    let nameAlert = UIAlertController(title: "Name Required", message: "Please enter your name before starting the game.", preferredStyle: .alert)
                    nameAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(nameAlert, animated: true)
                } else {
                    // Transition to next view controller
                    self.navigateToNextViewController(name: cleanedName)
                }
            }
        }
        
        // Add cancel action
        let cancleAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            
        }
        alertController.addAction(cancleAction)
        alertController.addAction(okAction)
        
        // Present alert
        present(alertController, animated: true, completion: nil)
    }
    
    
    func navigateToNextViewController(name: String) {
        // Assuming you have a storyboard ID for the next view controller
        if let nextVC = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController {
            // Pass data if needed
            Game.shared.playerName = name
            Game.shared.score = 0
            Game.shared.remainTime = Game.shared.selectedTime
            
            // Navigate to the next view controller
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
