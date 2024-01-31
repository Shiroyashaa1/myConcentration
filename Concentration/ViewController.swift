//
//  ViewController.swift
//  Concentration
//
//  Created by Mikhail Shelmakov on 20.01.2024.
//

import UIKit

class ViewController: UIViewController {
    var flipCount = 0 { 
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardsButtons: [UIButton]!
    
    var emojiChoices = ["🎃", "👻", "🎃", "👻"]
    
    @IBAction func touchCard(_ sender: UIButton) {
       flipCount += 1
        if let cardNumber = cardsButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("Choosen card was not in cardButtons")
        }
      
    }
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = .orange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
                
    }
    
}

