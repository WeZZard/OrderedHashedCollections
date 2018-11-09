//
//  OrderedSet+SetAlgebraTests.swift
//  OrderedHashedCollection
//
//  Created on 9/11/2018.
//

import XCTest

@testable
import OrderedHashedCollection


class OrderedSet_SetAlgebraTests: XCTestCase {
    class Object: Hashable {
        let int: Int
        init(int: Int) { self.int = int }
        var hashValue: Int { return int }
        static func == (lhs: Object, rhs: Object) -> Bool {
            return lhs.int == rhs.int
        }
    }
    
    // MARK: - Insert New Member
    func testInsertNewMember_returnsTrueAndNewMember_whenNewMemberWasNotContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object = Object(int: 0)
        
        let (inserted, memeberAfterInsert) = orderedSet.insert(object)
        
        XCTAssert(inserted)
        XCTAssert(memeberAfterInsert === object)
    }
    
    func testInsertNewMember_returnsFalseAndOldMember_whenNewMemberWasContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object1 = Object(int: 0)
        let object2 = Object(int: 0)
        
        orderedSet.insert(object1)
        
        let (inserted, memeberAfterInsert) = orderedSet.insert(object2)
        
        XCTAssert(!inserted)
        XCTAssert(memeberAfterInsert === object1)
    }
    
    func testInsertNewMember_insertsNewMemberToOrderedContainer_whenNewMemberWasNotContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object = Object(int: 0)
        
        orderedSet.insert(object)
        
        XCTAssert(orderedSet._ordered[0] == object)
    }
    
    func testInsertNewMember_insertsNewMemberToSetContainer_whenNewMemberWasNotContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object = Object(int: 0)
        
        orderedSet.insert(object)
        
        XCTAssert(orderedSet._set == [object])
    }
    
    func testInsertNewMember_doesNotInsertNewMemberToOrderedContainer_whenNewMemberWasContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object1 = Object(int: 0)
        let object2 = Object(int: 0)
        
        orderedSet.insert(object1)
        orderedSet.insert(object2)
        
        XCTAssert(orderedSet._ordered[0] === object1)
    }
    
    func testInsertNewMember_doesNotInsertNewMemberToSetContainer_whenNewMemberWasContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object1 = Object(int: 0)
        let object2 = Object(int: 0)
        
        orderedSet.insert(object1)
        orderedSet.insert(object2)
        
        XCTAssert(orderedSet._set.first! == object1)
    }
    
    // MARK: - Update with New Member
    func testUpdateWithNewMember_returnsNil_whenNewMemberWasNotContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object = Object(int: 0)
        
        let memeberAfterUpdate = orderedSet.update(with: object)
        
        XCTAssert(memeberAfterUpdate === nil)
    }
    
    func testUpdateWithNewMember_returnsOldMember_whenNewMemberWasContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object1 = Object(int: 0)
        let object2 = Object(int: 0)
        
        orderedSet.update(with: object1)
        
        let memeberAfterUpdate = orderedSet.update(with: object2)
        
        XCTAssert(memeberAfterUpdate === object1)
    }
    
    func testUpdateWithNewMember_insertsNewMemberToOrderedContainer_whenNewMemberWasNotContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object = Object(int: 0)
        
        orderedSet.update(with: object)
        
        XCTAssert(orderedSet._ordered[0] == object)
    }
    
    func testUpdateWithNewMember_insertsNewMemberToSetContainer_whenNewMemberWasNotContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object = Object(int: 0)
        
        orderedSet.update(with: object)
        
        XCTAssert(orderedSet._set == [object])
    }
    
    func testUpdateWithNewMember_doesNotInsertNewMemberToOrderedContainer_whenNewMemberWasContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object1 = Object(int: 0)
        let object2 = Object(int: 0)
        
        orderedSet.update(with: object1)
        orderedSet.update(with: object2)
        
        XCTAssert(orderedSet._ordered[0] === object2)
    }
    
    func testUpdateWithNewMember_doesNotInsertNewMemberToSetContainer_whenNewMemberWasContainedInOrderedSet() {
        var orderedSet = OrderedSet<Object>()
        
        let object1 = Object(int: 0)
        let object2 = Object(int: 0)
        
        orderedSet.update(with: object1)
        orderedSet.update(with: object2)
        
        XCTAssert(orderedSet._set.first! == object2)
    }
    
    // MARK: - Remove Element
    func testRemoveElement_returnsRemovedElement_forContainedElement() {
        var orderedSet = OrderedSet<Int>([0])
        
        XCTAssert(orderedSet.remove(0) == 0)
    }
    
    func testRemoveElement_returnsNil_forNotContainedElement() {
        var orderedSet = OrderedSet<Int>()
        
        XCTAssert(orderedSet.remove(0) == nil)
    }
    
    func testRemoveElement_removesElementInOrderedContainer_forContainedElement() {
        var orderedSet = OrderedSet<Int>([0])
        
        orderedSet.remove(0)
        
        XCTAssert(orderedSet._ordered.contains(0) == false)
    }
    
    func testRemoveElement_removesElementInSetContainer_forContainedElement() {
        var orderedSet = OrderedSet<Int>([0])
        
        orderedSet.remove(0)
        
        XCTAssert(orderedSet._set.contains(0) == false)
    }
    
    func testRemoveElement_doesNothingToOrderedContainer_forNotContainedElement() {
        var orderedSet = OrderedSet<Int>([0])
        
        let oldOrderedContainer = orderedSet._ordered
        
        orderedSet.remove(1)
        
        XCTAssert(orderedSet._ordered == oldOrderedContainer)
    }
    
    func testRemoveElement_doesNothingToSetContainer_forNotContainedElement() {
        var orderedSet = OrderedSet<Int>([0])
        
        let oldSetContainer = orderedSet._set
        
        orderedSet.remove(1)
        
        XCTAssert(orderedSet._set == oldSetContainer)
    }
    
    // MARK: - Union Other
    func testUnionOther_returnsUnion() {
        let a = OrderedSet<Int>([0, 1, 2, 3])
        let b = OrderedSet<Int>([4, 5, 6, 7])
        
        XCTAssert(a.union(b) == [0, 1, 2, 3, 4, 5, 6, 7])
    }
    
    // MARK: - Intersection Other
    func testIntersectionOther_returnsIntersection() {
        let a = OrderedSet<Int>([0, 1, 2, 3])
        let b = OrderedSet<Int>([2, 3, 4, 5])
        
        XCTAssert(a.intersection(b) == [2, 3])
    }
    
    // MARK: - Symmetric Difference Other
    func testSymmetricDifferenceOther_returnsSymmetricDifference() {
        let a = OrderedSet<Int>([0, 1, 2, 3])
        let b = OrderedSet<Int>([2, 3, 4, 5])
        
        XCTAssert(a.symmetricDifference(b) == [0, 1, 4, 5])
    }
}
