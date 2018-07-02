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
        
        //FAKE RETURN TRUE
        return true
    }
    
    mutating func select(card: Card) {
        if cardsSelected[buttonIndex] == cardsPlayed[buttonIndex] && cardsSelected.count < 3 {
            cardsSelected.removeValue(forKey: buttonIndex)
            return
        } else if cardsSelected[buttonIndex] == cardsPlayed[buttonIndex] && cardsSelected.count == 3 {
            return
        }
        
        if cardsSelected.count < 2 {
            cardsSelected[buttonIndex] = cardsPlayed[buttonIndex]
        } else if cardsSelected.count == 2 {
            cardsSelected[buttonIndex] = cardsPlayed[buttonIndex]
            //Check for match
            if isMatch {            //IS match
                
            }
        } else {
            if isMatch {
                dealNewCards()
                for matchIndex in cardsSelected.indices {
                    cardsMatched.append(cardsSelected[matchIndex].value)
                }
            }
            cardsSelected.removeAll()       //Remove all selected cards
            cardsSelected[buttonIndex] = cardsPlayed[buttonIndex]     //Reselect new first card
            
        }
    }
    
    mutating func dealNewCards() {
        if let (newCardOne, newCardTwo, newCardThree) = deck.drawThreeCards() {
            
        } else {
            
        }
        
        if isMatch {
            //Place new 3 cards in index spots of cardsSelected
            for index in cardsSelected.indices {
                cardsPlayed.remove(at: cardsPlayed.index(of: cardsSelected[index].value)!)
                cardsPlayed.insert(cardsInDeck.remove(at: cardsInDeck.count.random), at: cardsSelected[index].key)
            }
            cardsSelected.removeAll()
        }
        else {
            
        }
    }
    
    init() {
        //Deal 12 cards randomly, remove from cardsInDeck and place in cardsPlayed
        for _ in 0..<12 {
            cardsPlayed.append(cardsInDeck.remove(at: cardsInDeck.count.random))
        }
    }
}
