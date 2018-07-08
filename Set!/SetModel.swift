//
//  Set! Model
//
//  Created by Mark Johnson on 6/28/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//

import Foundation

struct Set {
    
    var deck = CardDeck()
    let totalNumberCards = 81
    private(set) var cardsPlayed = [Card]()
    private(set) var cardsSelected = [Card]()
    private(set) var cardsMatched = [Card]()
    var isMatch: Bool {
        guard cardsSelected.count == 3 else { return false }
        let cardSet: (cardOne: Card, cardTwo: Card, cardThree: Card) = (cardsSelected[0], cardsSelected[1], cardsSelected[2])
        if Card.compareColor(of: cardSet) && Card.compareCount(of: cardSet) && Card.compareShape(of: cardSet) && Card.compareShade(of: cardSet) {
            return true
        } else {
            return false
        }
    }
    
    mutating func select(card: Card) {
        let cardSelectedIndex = cardsSelected.lastIndex(of: card)
        
        if cardsSelected.contains(card) && cardsSelected.count < 3 {
            cardsSelected.remove(at: cardSelectedIndex!)
            return
        } else if cardsSelected.contains(card) && cardsSelected.count == 3 {
            if isMatch {
                return
            }
        }
        
        if cardsSelected.count < 3 {
            cardsSelected.append(card)
            return
        } else {
            if isMatch {
                dealNewCards()
            }
            cardsSelected.removeAll()       //Remove all selected cards
            cardsSelected.append(card)     //Reselect new first card
        }
    }
    
    mutating func dealNewCards() {
        if isMatch { cardsMatched.append(contentsOf: cardsSelected) }
        if let drawCardCheck = deck.drawThreeCards() {
            var newCards = [Card]()
            newCards.append(drawCardCheck)
            if isMatch {
                //Place new 3 cards in index spots of cardsSelected
                for selectedIndex in cardsSelected.indices {
                    let replacementLocation = cardsPlayed.lastIndex(of: cardsSelected[selectedIndex])!
                    cardsPlayed.remove(at: replacementLocation)
                    cardsPlayed.insert(newCards[selectedIndex], at: replacementLocation)
                }
                cardsSelected.removeAll()
            }
            else {
                cardsPlayed.append(contentsOf: newCards)
            }
        }
    }
    
    init() {
        //Deal 12 cards randomly, remove from cardsInDeck and place in cardsPlayed
        for _ in 1...4 {
            cardsPlayed.append(deck.drawThreeCards()!)
        }
    }
}


