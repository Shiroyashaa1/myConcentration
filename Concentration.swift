//
//  Concentration.swift
//  Concentration
//
//  Created by Mikhail Shelmakov on 31.01.2024.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIntex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIntex == nil {
                        foundIntex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIntex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched && !cards[index].isFaceUp {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func allCardsMatched() -> Bool {
        return cards.allSatisfy{$0.isMatched}
    }
    
    func resetGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        cards.shuffle()
    }
}
