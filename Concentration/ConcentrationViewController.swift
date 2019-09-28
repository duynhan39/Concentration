//
//  ViewController.swift
//  Concentration
//
//  Created by Cao Trong Duy Nhan on 2/13/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit



class ConcentrationViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
    
    private var inGame = false

    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private(set) var score = 0 {
        didSet {
            scoreBoard.text = "Score: \(score)"
        }
    }
    
    @IBOutlet private var startButton: [UIButton]!
    
    @IBAction private func startGame(_ sender: UIButton) {
        inGame = true
        
        gameName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
        
        chosenTheme = emojiChoices[emojiChoices.count.arc4random] as! (icons: Array<String>, colorThemes: Array<UIColor>)
        
        emoji = [Int:String]()
        
        flipCount = 0
        score = 0
        
        updateViewFromModel()
        
    }
    
    @IBOutlet weak var gameName: UILabel!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreBoard: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
//        let poem="""
//        I lay myself under the midnight sun
//        Feel the heat brusts through my wicked soul
//        I find myself alone on this hollow path
//        Asking the ghosts should I turn left or right
//        """
//        print(poem)
        
        if inGame {
            if let cardNumber = cardButtons.index(of: sender) {
                
                game.chooseCard(at: cardNumber)
                updateViewFromModel()
            }
            flipCount += game.flipCount
            score = game.score
        }
    }
    
    private func updateViewFromModel() {
        view.backgroundColor = chosenTheme.colorThemes[1]
        flipCountLabel.textColor = chosenTheme.colorThemes[0]
        scoreBoard.textColor = chosenTheme.colorThemes[0]
        startButton[0].backgroundColor = chosenTheme.colorThemes[0]
        startButton[0].setTitleColor(chosenTheme.colorThemes[1], for: UIControl.State.normal)
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : chosenTheme.colorThemes[0]
            }
        }
    }
    
    // MARK: Emoji controll
    
    //private static let numberOfThemes = 6
    
    private var emojiChoices = [
            (["❄️", "🌧", "🌬", "☃️", "🌫", "🐧", "🎅🏽", "🥶", "⛷", "🎄", "🦌", "🔔"], [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]),
            (["🤯", "😎", "🤬", "🤢", "🥶", "👹", "😈", "👾"], [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]),
            (["🧜🏼‍♂️", "🦄", "🧚🏻‍♀️", "🧞‍♂️", "👑", "🧝🏿‍♀️", "🦋", "🧙🏾‍♀️", "🦹🏽‍♂️"], [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]),
            (["🕋", "🗿", "🗽", "🏰", "🏯", "⛩", "🕍", "🕌", "🏛"], [#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)]),
            (["🍌", "🍮", "🍺", "🥐", "🍉", "🥬", "🍳", "🍲", "🍘", "🍤", "🧀", "🍇", "🍱", "🍧", "🍶", "🍰"], [#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]),
            (["🌆", "🌉", "🌌", "🌘", "🌃", "🌋", "🏜", "🌅", "🌄"], [#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)]),
            (["🦑", "🐋", "🦀", "🐙", "🐊", "🦈", "🐡", "🐠", "🐟", "🐬"], [#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]),
            (["🏟", "🏖", "🏕", "🛶", "⛵️", "🎇", "🎢", "🎲", "🎳", "🎨"], [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)])
            ] as [Any]
    
    private lazy var chosenTheme = emojiChoices[emojiChoices.count.arc4random] as! (icons: Array<String>, colorThemes: Array<UIColor>)
    
    //    private lazy var chosenTheme = emojiChoices[emojiChoices.count.arc4random] as! (icons: Array<String>, colorThemes: Array<UIColor>)
    
    //    private lazy var chosenTheme = (icons: ["❄️", "🌧", "🌬", "☃️", "🌫", "🐧", "🎅🏽", "🥶", "⛷", "🎄", "🦌", "🔔"], colorThemes: [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)])
    
    var theme: (icons: [String], colorThemes: [UIColor])? {
        didSet {
            chosenTheme = theme ?? (icons: [""], colorThemes: [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)])
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emoji = [Int:String]()     //Dictionary<Int, String>()
    
    private func emoji(for card: Card) -> String {
        //var chosenTheme = emojiChoices[selectedThemeNumber]
        if emoji[card.identifier] == nil, chosenTheme.icons.count > 0 {
            emoji[card.identifier] = chosenTheme.icons.remove(at: chosenTheme.icons.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"   // same as above
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}

