//
//  Set.swift
//  Set
//
//  Created by Chanchiew, Tana (Agoda) on 8/7/2564 BE.
//

import Foundation

struct Set {
    
    private(set) var deck = [CardValue]()
    
    private(set) var cards = [Card]()
    
    private(set) var selectedCards = [CardValue]()
    
    private(set) var setNumber: Int
    
    private(set) var score: Int
    
    private var unusedCardIndices = Array(0..<24)
    
    mutating func chooseCard(at index: Int) {
        if let value = cards[index].value {
            if selectedCards.count < 2 {
                if cards[index].isSelected {
                    selectedCards = selectedCards.filter { $0 != value }
                    score -= 1
                }
                else {
                    selectedCards.append(value)
                }
                cards[index].isSelected.toggle()
            }
            else if selectedCards.count == 2 {
                selectedCards.append(value)
                cards[index].isSelected.toggle()
                
                let card1 = selectedCards[0]
                let card2 = selectedCards[1]
                let card3 = selectedCards[2]
                var colorCmp = false
                var shadeCmp = false
                var shapeCmp = false
                var numberCmp = false
                
                if (card1.color == card2.color && card2.color == card3.color) || (card1.color != card2.color && card1.color != card3.color && card2.color != card3.color) {
                    colorCmp = true
                }
                if (card1.shade == card2.shade && card2.shade == card3.shade) || (card1.shade != card2.shade && card1.shade != card3.shade && card2.shade != card3.shade) {
                    shadeCmp = true
                }
                if (card1.shape == card2.shape && card2.shape == card3.shape) || (card1.shape != card2.shape && card1.shape != card3.shape && card2.shape != card3.shape) {
                    shapeCmp = true
                }
                if (card1.number == card2.number && card2.number == card3.number) || (card1.number != card2.number && card1.number != card3.number && card2.number != card3.number) {
                    numberCmp = true
                }
                
                if colorCmp && shadeCmp && shapeCmp && numberCmp {
                    score += 3
                    for selCard in selectedCards{
                        for index in 0..<cards.count {
                            if let cardValue = cards[index].value, cardValue == selCard {
                                cards[index].isShowed = false
                                cards[index].value = nil
                                unusedCardIndices.append(index)
                            }
                        }
                    }
                    score += 1
                }
                else {
                    score -= 5
                }
                
                for index in 0..<cards.count {
                    cards[index].isSelected = false
                }
                selectedCards = [CardValue]()
            }
        }
    }
        
    mutating func restart() {
        setNumber = 0
        score = 0
        
        deck = [CardValue]()
        let shapes = Shape.allCases
        let shades = Shade.allCases
        let colors = Color.allCases
        let numbers = [1,2,3]
        for index1 in 0..<3 {
            for index2 in 0..<3 {
                for index3 in 0..<3 {
                    for index4 in 0..<3 {
                        let card = CardValue(shape: shapes[index1], shade: shades[index2], color: colors[index3], number: numbers[index4])
                        deck.append(card)
                    }
                }
            }
        }
        
        cards = [Card]()
        
        unusedCardIndices = Array(0..<24)
        
        deck.shuffle()
        unusedCardIndices.shuffle()
        for _ in 0..<24 {
            cards += [Card()]
        }
        for index in 0..<12 {
            let randIndex = unusedCardIndices[index]
            cards[randIndex].isShowed = true
            cards[randIndex].value = deck[index]
        }
        deck = Array(deck[12..<deck.count])
        unusedCardIndices = Array(unusedCardIndices[12..<unusedCardIndices.count])
        
        selectedCards = [CardValue]()
    }
    
    mutating func drawCards() {
        let deckCount = deck.count
        let unusedCount = unusedCardIndices.count
        let drawNumber = deckCount < 3 && deckCount < unusedCount ? deckCount : unusedCount < 3 && unusedCount < deckCount ? unusedCount : 3
        
        for index in 0..<drawNumber {
            let randIndex = unusedCardIndices[index]
            cards[randIndex].isShowed = true
            cards[randIndex].value = deck[index]
        }
        deck = Array(deck[drawNumber..<deck.count])
        unusedCardIndices = Array(unusedCardIndices[drawNumber..<unusedCardIndices.count])
        if drawNumber != 0 {
            score -= 1
        }
    }
    
    init() {
        setNumber = 0
        score = 0
    }
}
