//
//  Card.swift
//  Concentration
//
//  Created by home on 29/6/21.
//

import Foundation

struct Card: Hashable {
    
    var isFaceUp = false
    var isMatch = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
