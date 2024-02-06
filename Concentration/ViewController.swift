//
//  ViewController.swift
//  Concentration
//
//  Created by Mikhail Shelmakov on 20.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardsButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardsButtons: [UIButton]!
 
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardsButtons.firstIndex(of: sender) {
            if !game.cards[cardNumber].isMatched && !game.cards[cardNumber].isFaceUp{
                flipCount += 1
            }
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Choosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardsButtons.indices {
            checkGameEnd()
            let button = cardsButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                UIView.animate(withDuration: 0.3, delay: 0.10, options: .curveEaseIn) {
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            }
        }
    }
        
    var emojiChoices = ["🎃", "👻", "😈", "🕸️", "🧛", "🙀", "😱", "🍭", "🍬"]
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let resetGameButton = UIButton()
        resetGameButton.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        resetGameButton.setTitle("Reset", for: .normal)
        resetGameButton.setTitleColor(.orange, for: .normal)
        resetGameButton.addTarget(self, action: #selector(resetGameButtonTapped), for: .touchUpInside)
        view.addSubview(resetGameButton)
    }
    
    func checkGameEnd() {
        if game.allCardsMatched() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.resetGameButtonTapped()
            }
        }
    }
    
    @objc func resetGameButtonTapped() {
        flipCount = 0
        game.resetGame()
        updateViewFromModel()
    }
}


