//
//  ViewController.swift
//  Concentration
//
//  Created by home on 29/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private lazy var game = Concentration(numberOfPairCards: numberOfPairCards)
    
    var numberOfPairCards : Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private(set) var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: Handle Card Touch Behavior
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    // MARK: Handle New Game Behavior
    
    @IBAction private func newGame(_ sender: UIButton) {
        game.restart()
        themes.shuffle()
        emojiChoices = themes[0]
        emoji = Dictionary<Card,String>()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for : card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatch ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
        }
        flipCount = game.flips
        score = game.scores
    }
    
    private var themes = ["🎃👻💀👽😈👹👺☠️","🐶🐱🐭🐹🐰🦊🐻🐯","🐙🦑🦐🦞🐠🐟🐳🦀","⚽️🏀🏈⚾️🎾🏐🏉🎱"]
    
    private var emojiChoices = "🎃👻😾👽😈💩👺🤖"
    
    private var emoji = Dictionary<Card,String>()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
    }
}

