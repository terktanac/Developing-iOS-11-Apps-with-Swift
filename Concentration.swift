//
//  Concentration.swift
//  Concentration
//
//  Created by home on 29/6/21.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatch {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatch = true
                    cards[index].isMatch = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        else {
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = false
            }
        }
    }
    
    init(numberOfPairCards: Int) {
        for _ in 1...numberOfPairCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
}
