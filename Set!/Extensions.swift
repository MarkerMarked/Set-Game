//
//  Extensions.swift
//  Set!
//
//  Created by Mark Johnson on 7/2/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//

import Foundation

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
