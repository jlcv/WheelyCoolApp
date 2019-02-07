//
//  CircleCalculator.swift
//  WheelyCoolApp
//
//  Created by jChavez17 on 2/6/19.
//  Copyright © 2019 jChavez17. All rights reserved.
//

import UIKit

struct CircleCalculator {
    static func getAngleSize(itemCount: Int) -> Float{
        return (2.0 * Float.pi / Float(itemCount))
    }
    
    static func generateRandomRotationValue(itemCount: Int) -> NSNumber {
        let randomNumber = Int.random(in: 0..<itemCount)
        return NSNumber(value: (Float.pi * 2 * 10 + getAngleSize(itemCount: itemCount) * Float(randomNumber)))
    }
}
