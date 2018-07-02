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
    
    init(with cardIndex: Int, colorType colorIndex: Int, shapeType shapeIndex: Int, shadeType shadeIndex: Int, countType countIndex: Int){
        identifier = cardIndex
        colorSetting = colorType(rawValue: colorIndex)!
        shapeSetting = shapeType(rawValue: shapeIndex)!
        shadeSetting = shadeType(rawValue: shadeIndex)!
        countSetting = countType(rawValue: countIndex)!
    }
}


