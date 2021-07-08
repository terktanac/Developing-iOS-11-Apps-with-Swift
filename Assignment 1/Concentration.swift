//
//  Concentration.swift
//  Concentration
//
//  Created by home on 29/6/21.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private(set) var flips: Int
    
    private(set) var score: Int
    
    private var seenCards = [Int]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): choosing index not in the cards")
        if !cards[index].isMatch {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatch = true
                    cards[index].isMatch = true
                    score += 2
                }
                else {
                    if seenCards.contains(index) || seenCards.contains(matchIndex) {
                        score -= 1
                    }
                    seenCards += [index]
                    seenCards += [matchIndex]
                }
                cards[index].isFaceUp = true
            }
            else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            flips += 1
        }
        else {
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = false
            }
        }
    }
    
    mutating func restart() {
        for index in cards.indices {
            cards[index].isFaceUp = true
            cards[index].isMatch = false
        }
        indexOfOneAndOnlyFaceUpCard = nil
        flips = 0
        score = 0
        seenCards = []
    }
    
    init(numberOfPairCards: Int) {
        assert(numberOfPairCards > 0, "Concentration.init(numberOfPairCards: \(numberOfPairCards): you must have at least one pair of cards")
        print("numberOfPairCards: \(numberOfPairCards)")
        for _ in 1...numberOfPairCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
        flips = 0
        score = 0
    }
    
}
