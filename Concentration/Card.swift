//
//  Card.swift
//  Concentration
//
//  Created by home on 29/6/21.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatch = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
