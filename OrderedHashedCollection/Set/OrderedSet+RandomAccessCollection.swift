//
//  OrderedSet+RandomAccessCollection.swift
//  OrderedHashedCollection
//
//  Created on 9/11/2018.
//


extension OrderedSet: RandomAccessCollection, MutableCollection {
    public typealias Index = Int
    
    public var startIndex: Index { return _ordered.startIndex }
    
    public var endIndex: Index { return _ordered.endIndex }
    
    public func index(after i: Int) -> Int {
        return _ordered.index(after: i)
    }
    
    public subscript(position: Index) -> Element {
        get { return _ordered[position] }
        set (newElement) {
            if _set.contains(newElement) {
                let sourceElement = _ordered[position]
                let sourcePosition = _ordered.index(of: newElement)!
                _ordered[position] = newElement
                _ordered[sourcePosition] = sourceElement
            } else {
                let oldElement = _ordered[position]
                _ordered[position] = newElement
                _set.remove(oldElement)
                _set.insert(newElement)
            }
        }
    }
    
    public func contains(_ element: Element) -> Bool {
        return _set.contains(element)
    }
    
    public var isEmpty: Bool {
        return _set.isEmpty
    }
}
