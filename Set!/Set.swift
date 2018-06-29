//
//  Set! Model
//
//  Created by Mark Johnson on 6/28/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//
//Lists - Cards being played, Selected Cards, Knows if selected cards are a match or no, Deck of cards, and list of already matched cards
//API - Select cards to try to match, and dealing 3 new cards on demand
//

import Foundation

struct Set {
    
    let numberOfCards = 81
    private(set) var cardsInDeck = [Card]()
    private(set) var cardsPlayed = [Card]()
    private(set) var cardsSelected = [Int : Card]()
    var isMatch: Bool {
        guard cardsSelected.count == 3 else { return false }
        
        //Fake return code
        return true
    }
    private(set) var cardsMatched = [Card]()
    
    mutating func selectCard(at buttonIndex: Int) {
        
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
        guard cardsInDeck.count != 0 else { return }
        if isMatch {
            //Place new 3 cards in index spots of cardsSelected
            for index in cardsSelected.indices {
                cardsPlayed.remove(at: cardsPlayed.index(of: cardsSelected[index].value)!)
                cardsPlayed.insert(cardsInDeck.remove(at: cardsInDeck.count.random), at: cardsSelected[index].key)
            }
            cardsSelected.removeAll()
        }
        else {
            cardsPlayed.append((cardsInDeck.remove(at: cardsInDeck.count.random),cardsInDeck.remove(at: cardsInDeck.count.random) ,cardsInDeck.remove(at: cardsInDeck.count.random)))
        }
    }
    
    init() {
        //Create cardsInDeck with all 81 cards
        var cardIndex = 0
        for colorIndex in 1...3 {
            for shapeIndex in 1...3{
                for shadeIndex in 1...3{
                    for countIndex in 1...3{
                        cardsInDeck.append(Card(with: cardIndex, colorType: colorIndex, shapeType: shapeIndex, shadeType: shadeIndex, countType: countIndex))
                        cardIndex += 1
                    }
                }
            }
        }
        //Deal 12 cards randomly, remove from cardsInDeck and place in cardsPlayed
        for _ in 0..<12 {
            cardsPlayed.append(cardsInDeck.remove(at: cardsInDeck.count.random))
        }
    }
}

struct Card: Hashable {
    
    var hashValue: Int {return identifier}
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    let identifier: Int
    let colorSetting: colorType
    let shapeSetting: shapeType
    let shadeSetting: shadeType
    let countSetting: countType
    
    init(with cardIndex: Int, colorType colorIndex: Int, shapeType shapeIndex: Int, shadeType shadeIndex: Int, countType countIndex: Int){
        identifier = cardIndex
        colorSetting = colorType(rawValue: colorIndex)!
        shapeSetting = shapeType(rawValue: shapeIndex)!
        shadeSetting = shadeType(rawValue: shadeIndex)!
        countSetting = countType(rawValue: countIndex)!
    }
}

enum colorType: Int { case colorOne = 1, colorTwo, colorThree }
enum shapeType: Int { case shapeOne = 1, shapeTwo, shapeThree }
enum shadeType: Int { case shadeOne = 1, shadeTwo, shadeThree }
enum countType: Int { case countOne = 1, countTwo, countThree }

extension Int {
    var random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0{
            return Int(arc4random_uniform(UInt32(abs(self))))
        }
        else{
            return 0
        }
    }
}

extension Array {
    mutating func append(_ elements:(Element, Element, Element)){
        self.append(elements.0)
        self.append(elements.1)
        self.append(elements.2)
    }
}

