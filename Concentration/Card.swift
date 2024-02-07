//
//  Card.swift
//  Concentration
//
//  Created by Mikhail Shelmakov on 31.01.2024.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getIdentifier()
    }
}
