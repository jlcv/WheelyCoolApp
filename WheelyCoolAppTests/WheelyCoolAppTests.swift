//
//  WheelyCoolAppTests.swift
//  WheelyCoolAppTests
//
//  Created by jChavez17 on 2/5/19.
//  Copyright © 2019 jChavez17. All rights reserved.
//

import XCTest

@testable import WheelyCoolApp

class WheelyCoolAppTests: XCTestCase {
    
    var resultGroups = [[Float]]()
    var numbersOfItemsToTest = [Int]()
    
    override func setUp() {
        numbersOfItemsToTest = [2, 3, 4, 5, 6, 7, 8]
        for (index, number) in numbersOfItemsToTest.enumerated() {
            resultGroups.append([])
            for _ in 0...999 {
                let result = CircleCalculator.generateRandomRotationValue(itemCount: number)
                resultGroups[index].append(result.floatValue)
            }
        }
    }
    
    func testAllValuesEvenlyReturned() {
        for (index, resultGroup) in resultGroups.enumerated() {
            let resultsWithValues = resultGroup.reduce(into: [:]) { $0[$1, default: 0] += 1 }
            let maxBoundary = getMaxBoundary(numberOfItems: numbersOfItemsToTest[index])
            let minBoundary = getMinBoundary(numberOfItems: numbersOfItemsToTest[index])
            for (_, value) in resultsWithValues {
                if ((Float(value) > maxBoundary) || (Float(value) < minBoundary)) {
                    XCTAssert(false)
                }
            }
        }
        XCTAssert(true)
    }
    
    private func getMaxBoundary(numberOfItems: Int) -> Float {
        return (1000.0 / Float(numberOfItems)) + ((1000.0 / 2.0) * 0.10)
    }
    
    private func getMinBoundary(numberOfItems: Int) -> Float {
        return (1000.0 / Float(numberOfItems)) - ((1000.0 / 2.0) * 0.10)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
