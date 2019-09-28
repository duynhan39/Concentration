//
//  Concentration.swift
//  Concentration
//
//  Created by Cao Trong Duy Nhan on 2/14/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    
    private(set) var flipCount = 0
    
    private(set) var score = 0
    
    private var startTime = Date()
    
    private var extraPoint: Int{
        get {
            let currentTime = Date()
            return 10 / Int(currentTime.timeIntervalSince(startTime)+2)
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        foundIndex = nil
                    }
                }
            }
            return foundIndex
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        var countSeen = 0
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) :chosen index not in the cards"  )
        flipCount = 0
        if !cards[index].isMatched {
            flipCount = 1
            if cards[index].beenSeen == true {
                countSeen+=1;
            }
            cards[index].beenSeen = true
            if let matchIndex = indexOfOneAndOnlyFaceUpCard {   // true if there is a card flipped up already
                if matchIndex != index {                        // true if user is clicking on a different card
                    cards[index].isFaceUp = true
                    
                    // Check if cards match
                    if cards[matchIndex].identifier == cards[index].identifier {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                        score += (2 + extraPoint)
                        score += countSeen
                    }
                    score-=countSeen;
                } else {
                    flipCount-=1
                }
                
            } else {
                startTime = Date()
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairOfCards: Int) {
        assert(numberOfPairOfCards > 0, "Concentration.init(:\(numberOfPairOfCards)) :There has to be at least 1 card"  )
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            //let matchingCard = card // copying since it's struct
//            card.append(card)
//            card.append(card) // copying it twice
            cards += [card, card] // append 2 more cards
        }
        var temp = [Card]()
        //var index = [Int]()
        for _ in 0..<(numberOfPairOfCards * 2) {
            
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            temp += [cards.remove(at: randomIndex)]
            //index+=[randomIndex]
            
        }
        
        cards = temp
    }
}
