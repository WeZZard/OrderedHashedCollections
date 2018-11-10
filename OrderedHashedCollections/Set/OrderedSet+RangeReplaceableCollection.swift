//
//  OrderedSet+RangeReplaceableCollection.swift
//  OrderedHashedCollections
//
//  Created on 9/11/2018.
//


extension OrderedSet: RangeReplaceableCollection {
    public init() {
        _ordered = []
        _set = []
    }
    
    public init<S: Sequence>(_ elements: S) where S.Element == Element {
        self.init()
        for eachElement in elements {
            append(eachElement)
        }
    }
    
    public mutating func append(_ newElement: Element) {
        if !_set.contains(newElement) {
            _ordered.append(newElement)
            _set.insert(newElement)
        } else {
            let index = _ordered.index(of: newElement)!
            _ordered.remove(at: index)
            _ordered.append(newElement)
        }
    }
    
    public mutating func append<S: Sequence>(contentsOf elements: S)
        where S.Element == Element
    {
        for eachElement in elements {
            append(eachElement)
        }
    }
    
    public mutating func insert(_ element: Element, at index: Index) {
        if !_set.contains(element) {
            _ordered.insert(element, at: index)
            _set.insert(element)
        } else {
            let oldIndex = _ordered.index(of: element)!
            _ordered.remove(at: oldIndex)
            let properIndex = Swift.min(index, _ordered.endIndex)
            _ordered.insert(element, at: properIndex)
            _set.insert(element)
        }
    }
    
    public mutating func insert<S: Sequence>(
        contentsOf elements: S,
        at index: Index
        ) where S.Element == Element
    {
        for (offset, eachElement) in elements.enumerated() {
            let insertIndex = Swift.min(_ordered.endIndex, index + offset)
            insert(eachElement, at: insertIndex)
        }
    }
    
    public mutating func replaceSubrange<C, R>(
        _ subrange: R, with newElements: C
        ) where C : Collection,
        R : RangeExpression,
        C.Element == Element,
        R.Bound == Index
    {
        let removed = _ordered[subrange]
        _ordered.removeSubrange(subrange)
        _set.subtract(removed)
        let start = subrange.relative(to: self).lowerBound
        for (offset, eachElement) in newElements.enumerated() {
            let insertIndex = Swift.min(_ordered.endIndex, start + offset)
            insert(eachElement, at: insertIndex)
        }
    }
    
    @discardableResult
    public mutating func remove(at index: Index) -> Element {
        let removed = _ordered.remove(at: index)
        _set.remove(removed)
        return removed
    }
    
    @discardableResult
    public mutating func removeFirst() -> Element {
        let removed = _ordered.removeFirst()
        _set.remove(removed)
        return removed
    }
    
    public mutating func removeFirst(_ k: Int) {
        let removed = _ordered.prefix(k)
        _ordered.removeFirst(k)
        _set.subtract(removed)
    }
    
    @discardableResult
    public mutating func removeLast() -> Element {
        let removed = _ordered.removeLast()
        _set.remove(removed)
        return removed
    }
    
    public mutating func removeLast(_ k: Int) {
        let removed = _ordered.suffix(k)
        _ordered.removeLast(k)
        _set.subtract(removed)
    }
    
    public mutating func removeAll(keepingCapacity: Bool=false) {
        _ordered.removeAll(keepingCapacity: keepingCapacity)
        _set.removeAll(keepingCapacity: keepingCapacity)
    }
    
    public mutating func removeAll(
        where predicate: (Element) throws -> Bool
        ) rethrows
    {
        var removedIndices = [Int]()
        var removedElements = [Element]()
        for (index, eachElement) in _ordered.enumerated() {
            if try predicate(eachElement) {
                removedIndices.append(index)
                removedElements.append(eachElement)
            }
        }
        for index in removedIndices.reversed() {
            _ordered.remove(at: index)
        }
        _set.subtract(removedElements)
    }
    
    public mutating func reserveCapacity(_ minimumCapacity: Int) {
        _ordered.reserveCapacity(minimumCapacity)
        _set.reserveCapacity(minimumCapacity)
    }
}
