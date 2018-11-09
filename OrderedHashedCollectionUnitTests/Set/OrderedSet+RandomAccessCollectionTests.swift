//
//  OrderedSet_RandomAccessCollectionTests.swift
//  OrderedHashedCollection
//
//  Created on 9/11/2018.
//

import XCTest

@testable
import OrderedHashedCollection


class OrderedSet_RandomAccessCollectionTests: XCTestCase {
    // MARK: Start Index
    func testStartIndex_returnsStartIndexOfOrderedContainer() {
        let orderedSet: OrderedSet<Int> = []
        XCTAssert(orderedSet.startIndex == orderedSet._ordered.startIndex)
    }
    
    func testStartIndex_doesNotChange_overMutation() {
        var orderedSet: OrderedSet<Int> = []
        XCTAssert(orderedSet.startIndex == orderedSet._ordered.startIndex)
        orderedSet._ordered.append(0)
        XCTAssert(orderedSet.startIndex == orderedSet._ordered.startIndex)
    }
    
    // MARK: End Index
    func testEndIndex_returnsEndIndexOfOrderedContainer() {
        var orderedSet: OrderedSet<Int> = []
        XCTAssert(orderedSet.endIndex == orderedSet._ordered.endIndex)
        orderedSet._ordered.append(0)
        XCTAssert(orderedSet.endIndex == orderedSet._ordered.endIndex)
    }
    
    // MARK: Insert After
    func testIndexAfter_returnsIndexAfterOfOrderedContainer() {
        let orderedSet: OrderedSet<Int> = []
        XCTAssert(orderedSet.index(after: orderedSet.startIndex) == orderedSet._ordered.index(after: orderedSet._ordered.startIndex))
    }
    
    // MARK: Subscript Get with Position
    func testSubscriptGetWithPosition_returnsElementAtIndexInOrderedContainer() {
        let orderedSet: OrderedSet<Int> = [0]
        
        XCTAssert(orderedSet[0] == orderedSet._ordered[0])
    }
    
    // MARK: Subscript Set with Position
    func testSubscriptSetWithPosition_replacesElementAtPositionOfOrderedContainer_withNotContainedElement() {
        var orderedSet: OrderedSet<Int> = [0]
        
        XCTAssert(orderedSet._ordered[0] == 0)
        orderedSet[0] = 1
        XCTAssert(orderedSet._ordered[0] == 1)
    }
    
    func testSubscriptSetWithPosition_replacesElementInSetContainer_whenElementIsLocatedAtIndex() {
        var orderedSet: OrderedSet<Int> = [0]
        
        XCTAssert(orderedSet._set == [0])
        orderedSet[0] = 0
        XCTAssert(orderedSet._set == [0])
    }
    
    func testSubscriptSetWithPosition_replacesElementInSetContainer_whenElementIsLocatedBeforeIndex() {
        var orderedSet: OrderedSet<Int> = [0, 1, 2]
        
        XCTAssert(orderedSet._set == [0, 1, 2])
        orderedSet[1] = 0
        XCTAssert(orderedSet._set == [0, 1, 2])
    }
    
    func testSubscriptSetWithPosition_replacesElementInSetContainer_whenElementIsLocatedAfterIndex() {
        var orderedSet: OrderedSet<Int> = [0, 1, 2]
        
        XCTAssert(orderedSet._set == [0, 1, 2])
        orderedSet[1] = 2
        XCTAssert(orderedSet._set == [0, 1, 2])
    }
    
    func testSubscriptSetWithPosition_replacesElementAtPositionOfOrderedContainer_withContainedElement() {
        var orderedSet: OrderedSet<Int> = [0]
        
        XCTAssert(orderedSet._ordered[0] == 0)
        orderedSet[0] = 1
        XCTAssert(orderedSet._ordered[0] == 1)
    }
    
    func testSubscriptSetWithPosition_replacesElementAtPositionOfOrderedContainer_whenElementIsLocatedBeforeIndex() {
        var orderedSet: OrderedSet<Int> = [0, 1, 2]
        
        XCTAssert(orderedSet._ordered == [0, 1, 2])
        orderedSet[1] = 0
        XCTAssert(orderedSet._ordered == [1, 0, 2])
    }
    
    func testSubscriptSetWithPosition_replacesElementAtPositionOfOrderedContainer_whenElementIsLocatedAfterIndex() {
        var orderedSet: OrderedSet<Int> = [0, 1, 2]
        
        XCTAssert(orderedSet._ordered == [0, 1, 2])
        orderedSet[1] = 2
        XCTAssert(orderedSet._ordered == [0, 2, 1])
    }
    
    func testSubscriptSetWithPosition_replacesElementInSetContainer_withContainedElement() {
        var orderedSet: OrderedSet<Int> = [0]
        
        XCTAssert(orderedSet._set == [0])
        orderedSet[0] = 1
        XCTAssert(orderedSet._set == [1])
    }
    
    // MARK: Contains Element
    func testContainsElement_returnsTrue_whenElementIsInSetContainer() {
        var orderedSet: OrderedSet<Int> = []
        orderedSet._set.insert(0)
        XCTAssert(orderedSet.contains(0))
    }
    
    func testContainsElement_returnsFalse_whenElementIsNotInSetContainer() {
        let orderedSet: OrderedSet<Int> = []
        XCTAssert(orderedSet.contains(0) == false)
    }
    
    // MARK: Is Empty
    func testIsEmpty_returnsTrue_whenSetStorageIsEmpty() {
        let orderedSet: OrderedSet<Int> = []
        XCTAssert(orderedSet.isEmpty)
    }
    
    func testIsEmpty_returnsFalse_whenSetStorageIsNotEmpty() {
        var orderedSet: OrderedSet<Int> = []
        orderedSet._set.insert(0)
        XCTAssert(orderedSet.isEmpty == false)
    }
}
