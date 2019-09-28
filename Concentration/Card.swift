//
//  Card.swift
//  Concentration
//
//  Created by Cao Trong Duy Nhan on 2/14/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var beenSeen = false
    var identifier: Int
    
    static private var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
