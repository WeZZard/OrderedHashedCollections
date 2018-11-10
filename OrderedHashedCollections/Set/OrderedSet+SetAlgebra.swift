//
//  OrderedSet+SetAlgebra.swift
//  OrderedHashedCollections
//
//  Created on 9/11/2018.
//


extension OrderedSet: SetAlgebra {
    @discardableResult
    public mutating func insert(_ newMember: E)
        -> (inserted: Bool, memberAfterInsert: E)
    {
        let (inserted, memberAfterInsert) = _set.insert(newMember)
        if let index = _ordered.index(of: newMember) {
            _ordered[index] = memberAfterInsert
        } else {
            _ordered.append(memberAfterInsert)
        }
        return (inserted, memberAfterInsert)
    }
    
    @discardableResult
    public mutating func update(with newMember: Element) -> Element? {
        if let oldMember = _set.update(with: newMember) {
            let index = _ordered.index(of: oldMember)!
            _ordered[index] = newMember
            return oldMember
        } else {
            _ordered.append(newMember)
        }
        return nil
    }
    
    @discardableResult
    public mutating func remove(_ element: Element) -> Element? {
        if let removed = _set.remove(element) {
            let index = _ordered.index(of: removed)!
            _ordered.remove(at: index)
            return removed
        }
        return nil
    }
    
    public func union(_ other: OrderedSet) -> OrderedSet {
        var unioned = self
        for eachElement in other {
            if !unioned._set.contains(eachElement) {
                unioned._ordered.append(eachElement)
                unioned._set.insert(eachElement)
            }
        }
        return unioned
    }
    
    public func intersection(_ other: OrderedSet) -> OrderedSet {
        var intersected: OrderedSet = .init()
        for eachElement in other {
            if _set.contains(eachElement) {
                intersected._ordered.append(eachElement)
                intersected._set.insert(eachElement)
            }
        }
        return intersected
    }
    
    public func symmetricDifference(_ other: OrderedSet) -> OrderedSet {
        var symmetricDifferenced: OrderedSet = .init()
        for eachElement in self {
            if !other.contains(eachElement) {
                symmetricDifferenced._ordered.append(eachElement)
                symmetricDifferenced._set.insert(eachElement)
            }
        }
        
        for eachElement in other {
            if !contains(eachElement) {
                symmetricDifferenced._ordered.append(eachElement)
                symmetricDifferenced._set.insert(eachElement)
            }
        }
        return symmetricDifferenced
    }
    
    public mutating func formUnion(_ other: OrderedSet) {
        self = union(other)
    }
    
    public mutating func formIntersection(_ other: OrderedSet) {
        self = intersection(other)
    }
    
    public mutating func formSymmetricDifference(_ other: OrderedSet) {
        self = symmetricDifference(other)
    }
}
