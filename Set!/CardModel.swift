//
//  CardModel.swift
//  Set!
//
//  Created by Mark Johnson on 7/2/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int {return identifier}
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    enum colorType: Int { case colorOne = 1, colorTwo, colorThree }
    enum shapeType: Int { case shapeOne = 1, shapeTwo, shapeThree }
    enum shadeType: Int { case shadeOne = 1, shadeTwo, shadeThree }
    enum countType: Int { case countOne = 1, countTwo, countThree }
    
    let identifier: Int
    let colorSetting: colorType
    let shapeSetting: shapeType
    let shadeSetting: shadeType
    let countSetting: countType
    
    //Returns TRUE if all three cards are ALL SAME or ALL DIFFERENT color, false if 2x type, 1x other type.
    static func compareColor(of cardSet: (Card, Card, Card)) -> Bool {
        let (cardOne, cardTwo, cardThree) = cardSet
        if cardOne.colorSetting == cardTwo.colorSetting && cardOne.colorSetting == cardThree.colorSetting {
            return true
        } else if cardOne.colorSetting != cardTwo.colorSetting && cardOne.colorSetting != cardThree.colorSetting && cardTwo.colorSetting != cardThree.colorSetting{
            return true
        } else {
            return false
        }
    }
    
    //Returns TRUE if all three cards are ALL SAME or ALL DIFFERENT shape, false if 2x type, 1x other type.
    static func compareShape(of cardSet: (Card, Card, Card)) -> Bool {
        let (cardOne, cardTwo, cardThree) = cardSet
        if cardOne.shapeSetting == cardTwo.shapeSetting && cardOne.shapeSetting == cardThree.shapeSetting {
            return true
        } else if cardOne.shapeSetting != cardTwo.shapeSetting && cardOne.shapeSetting != cardThree.shapeSetting && cardTwo.shapeSetting != cardThree.shapeSetting{
            return true
        } else {
            return false
        }
    }
    
    //Returns TRUE if all three cards are ALL SAME or ALL DIFFERENT shade, false if 2x type, 1x other type.
    static func compareShade(of cardSet: (Card, Card, Card)) -> Bool {
        let (cardOne, cardTwo, cardThree) = cardSet
        if cardOne.shadeSetting == cardTwo.shadeSetting && cardOne.shadeSetting == cardThree.shadeSetting {
            return true
        } else if cardOne.shadeSetting != cardTwo.shadeSetting && cardOne.shadeSetting != cardThree.shadeSetting && cardTwo.shadeSetting != cardThree.shadeSetting{
            return true
        } else {
            return false
        }
    }
    
    //Returns TRUE if all three cards are ALL SAME or ALL DIFFERENT count, false if 2x type, 1x other type.
    static func compareCount(of cardSet: (Card, Card, Card)) -> Bool {
        let (cardOne, cardTwo, cardThree) = cardSet
        if cardOne.countSetting == cardTwo.countSetting && cardOne.countSetting == cardThree.countSetting {
            return true
        } else if cardOne.countSetting != cardTwo.countSetting && cardOne.countSetting != cardThree.countSetting && cardTwo.countSetting != cardThree.countSetting{
            return true
        } else {
            return false
        }
    }
    
    
    init(with cardIndex: Int, colorType colorIndex: Int, shapeType shapeIndex: Int, shadeType shadeIndex: Int, countType countIndex: Int){
        identifier = cardIndex
        colorSetting = colorType(rawValue: colorIndex)!
        shapeSetting = shapeType(rawValue: shapeIndex)!
        shadeSetting = shadeType(rawValue: shadeIndex)!
        countSetting = countType(rawValue: countIndex)!
    }
}


