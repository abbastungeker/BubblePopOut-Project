//
//  SettingViewController.swift
//  BubblePopOut
//
//  Created on 25/04/2024.
//

import UIKit

class SettingViewController: UIViewController {
    
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bubbleLabel: UILabel!
    @IBOutlet weak var timerSlider: UISlider!
    @IBOutlet weak var bubbleSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "\(Game.shared.selectedTime)"
        timerSlider.value = Float(Game.shared.selectedTime)
        bubbleLabel.text = "\(Game.shared.maxBubbles)"
        bubbleSlider.value = Float(Game.shared.maxBubbles)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func timeSliderAction(_ sender: UISlider) {
        let selectedValue = Int(sender.value)
        self.timeLabel.text = "\(selectedValue)"
        Game.shared.selectedTime = selectedValue
        Game.shared.remainTime = selectedValue
    }
    

    @IBAction func bubbleSliderAction(_ sender: UISlider) {
        self.bubbleLabel.text = "\(Int(sender.value))"
        Game.shared.maxBubbles = Int(sender.value)
    }
    

}
