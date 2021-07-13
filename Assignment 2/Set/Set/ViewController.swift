//
//  ViewController.swift
//  Set
//
//  Created by Chanchiew, Tana (Agoda) on 8/7/2564 BE.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private lazy var game = Set()
    
    private(set) var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.restart()
        updateViewFromModel()
    }
    
    @IBAction func drawCards(_ sender: UIButton) {
        game.drawCards()
        updateViewFromModel()
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isShowed {
                if let value = card.value {
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    button.setAttributedTitle(value.toNSAttributedString(), for: .normal)
                }
                if card.isSelected {
                    button.layer.borderWidth = 10.0
                    button.layer.borderColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
                }
                else {
                    button.layer.borderWidth = 0.0
                }
            }
            else {
                button.setTitle("", for: .normal)
                button.setAttributedTitle(nil, for: .normal)
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                button.layer.borderWidth = 0.0
            }
        }
        score = game.score
    }
}

