//
//  OrderedSet+RangeReplaceableCollectionTests.swift
//  OrderedHashedCollection
//
//  Created on 9/11/2018.
//

import XCTest

@testable
import OrderedHashedCollection


class OrderedSet_RangeReplaceableCollectionTests: XCTestCase {
    // MARK: - Init
    func testInit_createsInstanceWithNoElementsInOrderedContainer() {
        let orderedSet = OrderedSet<Int>()
        XCTAssert(orderedSet._ordered.isEmpty)
    }
    
    func testInit_createsInstanceWithNoElementsInSetContainer() {
        let orderedSet = OrderedSet<Int>()
        XCTAssert(orderedSet._set.isEmpty)
    }
    
    // MARK: - Init with Elements
    func testInitWithElements_createsInstanceWithElementsInOrderedContainer() {
        let elements = [0, 1, 2, 3]
        let orderedSet = OrderedSet<Int>(elements)
        XCTAssert(orderedSet._ordered == elements)
    }
    
    func testInitWithElements_createsInstanceWithElementsInSetContainer() {
        let elements = [0, 1, 2, 3]
        let orderedSet = OrderedSet<Int>(elements)
        XCTAssert(orderedSet._set == Set(elements))
    }
    
    func testInitWithElements_createsInstanceWithNonDuplicateElementsInOrderedContainer_withDuplicateElements() {
        let elements = [0, 1, 1, 2, 2, 3]
        let orderedSet = OrderedSet<Int>(elements)
        XCTAssert(orderedSet._ordered == [0, 1, 2, 3])
    }
    
    func testInitWithElements_createsInstanceWithNonDuplicateElementsInSetContainer_withDuplicateElements() {
        let elements = [0, 1, 1, 2, 2, 3]
        let orderedSet = OrderedSet<Int>(elements)
        XCTAssert(orderedSet._set == [0, 1, 2, 3])
    }
    
    // MARK: - Append Element
    func testAppendElement_appendsElementToTheEndOfOrderedContainer_withNotContainedElement() {
        let element = 0
        var orderedSet = OrderedSet<Int>()
        XCTAssert(orderedSet._ordered.contains(element) == false)
        orderedSet.append(element)
        XCTAssert(orderedSet._ordered.contains(element))
    }
    
    func testAppendElement_appendsElementToSetContainer_withNotContainedElement() {
        let element = 0
        var orderedSet = OrderedSet<Int>()
        XCTAssert(orderedSet._set.contains(element) == false)
        orderedSet.append(element)
        XCTAssert(orderedSet._set.contains(element))
    }
    
    func testAppendElement_appendsElementToOrderedContainer_withContainedElement() {
        let element = 1
        let elements = [0, 1, 2]
        var orderedSet = OrderedSet<Int>(elements)
        
        XCTAssert(orderedSet._ordered.contains(element))
        XCTAssert(orderedSet._ordered[1] == element)
        orderedSet.append(element)
        XCTAssert(orderedSet._ordered.contains(element))
        XCTAssert(orderedSet._ordered[2] == element)
    }
    
    func testAppendElement_doesNotMakeChangeToSetContainer_withContainedElement() {
        let element = 1
        let elements = [0, 1, 2]
        var orderedSet = OrderedSet<Int>(elements)
        
        XCTAssert(orderedSet._set.contains(element))
        XCTAssert(orderedSet._set == Set(elements))
        orderedSet.append(element)
        XCTAssert(orderedSet._set.contains(element))
        XCTAssert(orderedSet._set == Set(elements))
    }
    
    // MARK: - Append Contents of Elements
    func testAppendContentsOfElements_appendsElementsToOrderedContainer_withNotContainedElements() {
        let elements = [0, 1, 2, 3]
        var orderedSet = OrderedSet<Int>()
        XCTAssert(Set(orderedSet._ordered).intersection(elements).isEmpty)
        orderedSet.append(contentsOf: elements)
        XCTAssert(orderedSet._ordered == elements)
    }
    
    func testAppendContentsOfElements_appendsElementsToOrderedContainer_withSequenceOfElementsWhichContainedExistedElements() {
        let elements = [0, 1, 2, 3]
        var orderedSet = OrderedSet<Int>([1, 2])
        XCTAssert(Set(orderedSet._ordered).intersection(elements) == [1, 2])
        orderedSet.append(contentsOf: elements)
        XCTAssert(orderedSet._ordered == elements)
    }
    
    func testAppendContentsOfElements_appendsElementsToSetContainer_withNotContainedElements() {
        let elements = [0, 1, 2, 3]
        var orderedSet = OrderedSet<Int>()
        XCTAssert(orderedSet._set.intersection(elements).isEmpty)
        orderedSet.append(contentsOf: elements)
        XCTAssert(orderedSet._set == Set(elements))
    }
    
    func testAppendContentsOfElements_appendsElementsToSetContainer_withSequenceOfElementsWhichContainedExistedElements() {
        let elements = [0, 1, 2, 3]
        var orderedSet = OrderedSet<Int>([1, 2])
        XCTAssert(Set(orderedSet._set).intersection(elements) == [1, 2])
        orderedSet.append(contentsOf: elements)
        XCTAssert(orderedSet._set == Set(elements))
    }
    
    // MARK: - Insert Element at Index
    func testInsertElementAtIndex_insertsElementToIndexedPositionOfOrderedContainer_withNotContainedElement() {
        var orderedSet = OrderedSet<Int>()
        
        orderedSet.insert(0, at: 0)
        
        XCTAssert(orderedSet._ordered[0] == 0)
    }
    
    func testInsertElementAtIndex_insertsElementToIndexedPositionOfOrderedContainer_whereElementIsLocatedAtIndex() {
        var orderedSet = OrderedSet<Int>([0, 1, 2])
        
        orderedSet.insert(1, at: 1)
        
        XCTAssert(orderedSet._ordered == [0, 1, 2])
    }
    
    func testInsertElementAtIndex_insertsElementToPrecededIndexedPositionOfOrderedContainer_whereElementIsLocatedBeforeIndex() {
        var orderedSet = OrderedSet<Int>([0, 1, 2])
        
        orderedSet.insert(1, at: 3)
        
        XCTAssert(orderedSet._ordered == [0, 2, 1])
    }
    
    func testInsertElementAtIndex_insertsElementToIndexedPositionOfOrderedContainer_whereElementIsLocatedAfterIndex() {
        var orderedSet = OrderedSet<Int>([0, 1])
        
        orderedSet.insert(1, at: 0)
        
        XCTAssert(orderedSet._ordered[0] == 1)
    }
    
    // MARK: - Insert Contents of Elements at Index
    func testInsertContentsOfElementsAtIndex_insertsElementToIndexedPositionOfOrderedContainer_withNotContainedElement() {
        var orderedSet = OrderedSet<Int>([0, 1])
        
        orderedSet.insert(contentsOf: [2, 3], at: 0)
        
        XCTAssert(orderedSet._ordered == [2, 3, 0, 1])
    }
    
    func testInsertContentsOfElementsAtIndex_insertsElementToPrecededIndexedPositionOfOrderedContainer_withForwardContainedElement() {
        var orderedSet = OrderedSet<Int>([0, 1])
        
        orderedSet.insert(contentsOf: [0, 2], at: 2)
        
        XCTAssert(orderedSet._ordered == [1, 0, 2])
    }
    
    func testInsertContentsOfElementsAtIndex_insertsElementToIndexedPositionOfOrderedContainer_withBackwardContainedElement() {
        var orderedSet = OrderedSet<Int>([0, 1])
        
        orderedSet.insert(contentsOf: [0, 2], at: 2)
        
        XCTAssert(orderedSet._ordered == [1, 0, 2])
    }
    
    // MARK: - Replace Subrange with New Elements
    
    // MARK: - Remove at Index
    func testRemoveAtIndex_returnsRemovedElementAtIndex() {
        var orderedSet = OrderedSet<Int>([0])
        
        XCTAssert(orderedSet.remove(at: 0) == 0)
    }
    
    func testRemoveAtIndex_removesElementInOrderedContainer() {
        var orderedSet = OrderedSet<Int>([0])
        
        orderedSet.remove(at: 0)
        
        XCTAssert(orderedSet._ordered.contains(0) == false)
    }
    
    func testRemoveAtIndex_removesElementInSetContainer() {
        var orderedSet = OrderedSet<Int>([0])
        
        orderedSet.remove(at: 0)
        
        XCTAssert(orderedSet._set.contains(0) == false)
    }
    
    // MARK: - Remove First
    func testRemoveFirst_removesFirstElementInOrderedContainer() {
        var orderedSet = OrderedSet<Int>([0, 1])
        
        orderedSet.removeFirst()
        
        XCTAssert(orderedSet._ordered == [1])
    }
    
    func testRemoveFirst_removesFirstElementInSetContainer() {
        var orderedSet = OrderedSet<Int>([0, 1])
        
        orderedSet.removeFirst()
        
        XCTAssert(orderedSet._set == [1])
    }
    
    // MARK: - Remove First K
    func testRemoveFirstK_removesFirstKElementInOrderedContainer() {
        var orderedSet = OrderedSet<Int>([0, 1, 2])
        
        orderedSet.removeFirst(2)
        
        XCTAssert(orderedSet._ordered == [2])
    }
    
    func testRemoveFirstK_removesFirstKElementInSetContainer() {
        var orderedSet = OrderedSet<Int>([0, 1, 2])
        
        orderedSet.removeFirst(2)
        
        XCTAssert(orderedSet._set == [2])
    }
    
    // MARK: - Remove Last
    func testRemoveLast_removesFirstElementInOrderedContainer() {
        var orderedSet = OrderedSet<Int>([0, 1])
        
        orderedSet.removeLast()
        
        XCTAssert(orderedSet._ordered == [0])
    }
    
    func testRemoveLast_removesFirstElementInSetContainer() {
        var orderedSet = OrderedSet<Int>([0, 1])
        
        orderedSet.removeLast()
        
        XCTAssert(orderedSet._set == [0])
    }
    
    // MARK: - Remove Last K
    func testRemoveLastK_removesLastKElementInOrderedContainer() {
        var orderedSet = OrderedSet<Int>([0, 1, 2])
        
        orderedSet.removeLast(2)
        
        XCTAssert(orderedSet._ordered == [0])
    }
    
    func testRemoveLastK_removesLastKElementInSetContainer() {
        var orderedSet = OrderedSet<Int>([0, 1, 2])
        
        orderedSet.removeLast(2)
        
        XCTAssert(orderedSet._set == [0])
    }
    
    // MARK: - Remove All Keeps Capacity
    func testRemoveAllKeepingCapacity_removesAllElementsInOrderedContainer_withTrue() {
        var orderedSet = OrderedSet<Int>([0, 1, 2, 3])
        
        orderedSet.removeAll(keepingCapacity: true)
        
        XCTAssert(orderedSet._ordered.isEmpty)
    }
    
    func testRemoveAllKeepingCapacity_removesAllElementsInSetContainer_withTrue() {
        var orderedSet = OrderedSet<Int>([0, 1, 2, 3])
        
        orderedSet.removeAll(keepingCapacity: true)
        
        XCTAssert(orderedSet._ordered.isEmpty)
    }
    
    func testRemoveAllKeepingCapacity_removesAllElementsInOrderedContainer_withFalse() {
        var orderedSet = OrderedSet<Int>([0, 1, 2, 3])
        
        orderedSet.removeAll(keepingCapacity: false)
        
        XCTAssert(orderedSet._set.isEmpty)
    }
    
    func testRemoveAllKeepingCapacity_removesAllElementsInSetContainer_withFalse() {
        var orderedSet = OrderedSet<Int>([0, 1, 2, 3])
        
        orderedSet.removeAll(keepingCapacity: false)
        
        XCTAssert(orderedSet._set.isEmpty)
    }
    
    func testRemoveAllKeepingCapacity_keepsCapacityForOrderedContainer_withTrue() {
        var orderedSet = OrderedSet<Int>([0, 1, 2, 3])
        
        let oldCapacity = orderedSet._ordered.capacity
        
        orderedSet.removeAll(keepingCapacity: true)
        
        XCTAssert(orderedSet._ordered.capacity == oldCapacity)
    }
    
    func testRemoveAllKeepingCapacity_keepsCapacityForSetContainer_withTrue() {
        var orderedSet = OrderedSet<Int>([0, 1, 2, 3])
        
        let oldCapacity = orderedSet._set.capacity
        
        orderedSet.removeAll(keepingCapacity: true)
        
        XCTAssert(orderedSet._set.capacity == oldCapacity)
    }
    
    func testRemoveAllKeepingCapacity_doesNotKeepsCapacityForOrderedContainer_withFalse() {
        var orderedSet = OrderedSet<Int>([0, 1, 2, 3])
        
        let oldCapacity = orderedSet._ordered.capacity
        
        orderedSet.removeAll(keepingCapacity: false)
        
        XCTAssert(orderedSet._ordered.capacity != oldCapacity)
    }
    
    func testRemoveAllKeepingCapacity_doesNotKeepsCapacityForSetContainer_withFalse() {
        var orderedSet = OrderedSet<Int>([0, 1, 2, 3])
        
        let oldCapacity = orderedSet._set.capacity
        
        orderedSet.removeAll(keepingCapacity: false)
        
        XCTAssert(orderedSet._set.capacity != oldCapacity)
    }
    
    // MARK: - Remove All Where Predicate
    func testRemoveAllWherePredicate_removesAllPredicatedInOrderedContainer() {
        var orderedSet = OrderedSet<Int>([0, 1, 2, 4])
        
        orderedSet.removeAll(where: { $0 < 2})
        
        XCTAssert(orderedSet._ordered == [2, 4])
    }
    
    func testRemoveAllWherePredicate_removesAllPredicatedInSetContainer() {
        var orderedSet = OrderedSet<Int>([0, 1, 2, 4])
        
        orderedSet.removeAll(where: { $0 < 2})
        
        XCTAssert(orderedSet._set == [2, 4])
    }
    
    // MARK: - Reserve Capacity with Minimum Capacity
    func testReserveCapacityWithMinimumCapacity_reservesCapacityWithMinimumCapacityForOrderedContainer() {
        var orderedSet = OrderedSet<Int>()
        
        let oldCapacity = orderedSet._ordered.capacity
        
        orderedSet.reserveCapacity(10)
        
        XCTAssert(orderedSet._ordered.capacity != oldCapacity)
        XCTAssert(orderedSet._ordered.capacity >= 10)
    }
    
    func testReserveCapacityWithMinimumCapacity_reservesCapacityWithMinimumCapacityForSetContainer() {
        var orderedSet = OrderedSet<Int>()
        
        let oldCapacity = orderedSet._set.capacity
        
        orderedSet.reserveCapacity(10)
        
        XCTAssert(orderedSet._set.capacity != oldCapacity)
        XCTAssert(orderedSet._set.capacity >= 10)
    }
}
