//
//  OrderedSetTests.swift
//  OrderedHashedCollections
//
//  Created on 9/11/2018.
//

import XCTest

@testable
import OrderedHashedCollections


class OrderedSetTests: XCTestCase {
    func testHashValue_returnsHashValueOfSetContainer() {
        let orderedSet: OrderedSet<Int> = [0, 1, 2, 3]
        
        XCTAssert(orderedSet.hashValue == orderedSet._set.hashValue)
    }
    
    func testEqual_returnsTrue_whenOrderedContainerOfLhsAndRhsIsEqual() {
        let a = OrderedSet<Int>([0, 1, 2, 3])
        let b = OrderedSet<Int>([0, 1, 2, 3])
        
        XCTAssert(a == b)
    }
    
    func testEqual_returnsFalse_whenOrderedContainerOfLhsAndRhsIsInequal_setContainerOfLhsAndRhsIsEqual() {
        let a = OrderedSet<Int>([0, 1, 2, 3])
        let b = OrderedSet<Int>([3, 2, 1, 0])
        
        XCTAssert(a != b)
    }
    
    func testEqual_returnsFalse_whenOrderedContainerOfLhsAndRhsIsInequal_setContainerOfLhsAndRhsIsInequal() {
        let a = OrderedSet<Int>([0, 1, 2, 3])
        let b = OrderedSet<Int>([])
        
        XCTAssert(a != b)
    }
}
