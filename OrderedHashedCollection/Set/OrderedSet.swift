//
//  OrderedSet.swift
//  OrderedHashedCollection
//
//  Created on 9/11/2018.
//

/// A naïve implementation to generic set collection which stores values
/// in an ordered maner.
///
public struct OrderedSet<E: Hashable>: Hashable,
    CustomStringConvertible,
    CustomDebugStringConvertible
{
    public typealias Element = E
    
    internal var _ordered: Array<Element>
    
    internal var _set: Set<Element>
    
    public static func == (lhs: OrderedSet, rhs: OrderedSet) -> Bool {
        return lhs._ordered == rhs._ordered
    }
    
    public var hashValue: Int { return _set.hashValue }
    
    public var description: String {
        let contents = map({"\($0)"}).joined(separator: ", ")
        return "[\(contents)]"
    }
    
    public var debugDescription: String {
        return "<\(type(of: self)); Elements = \(description)>"
    }
}


extension OrderedSet: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Element
    
    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self.init(elements)
    }
}
