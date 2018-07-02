//
//  CardDeckModel.swift
//  Set!
//
//  Created by Mark Johnson on 7/2/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//

import Foundation

struct CardDeck {
    private(set) var cards = [Card]()
    
    var numberInDeck: Int {
        return cards.count
    }
    
    mutating func drawThreeCards() -> (Card, Card, Card)? {
        guard self.numberInDeck > 0 else { return nil }
        return (cards.remove(at: self.numberInDeck.random), cards.remove(at: self.numberInDeck.random), cards.remove(at: self.numberInDeck.random))
    }
    
    init() {
        var cardIndex = 0
        for colorIndex in 1...3 {
            for shapeIndex in 1...3{
                for shadeIndex in 1...3{
                    for countIndex in 1...3{
                        cards.append(Card(with: cardIndex, colorType: colorIndex, shapeType: shapeIndex, shadeType: shadeIndex, countType: countIndex))
                        cardIndex += 1
                    }
                }
            }
        }
    }
    
    
}
