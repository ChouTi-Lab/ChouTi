// Copyright © 2020 ChouTi. All rights reserved.

import Foundation

public struct OrderedDictionary<KeyType: Hashable, ValueType> {
  private(set) var array: [KeyType] = []
  private(set) var dictionary: [KeyType: ValueType] = [:]

  public var count: Int { return array.count }

  public init() {}

  public subscript(key: KeyType) -> ValueType? {
    get {
      return dictionary[key]
    }

    set {
      if array.firstIndex(of: key) == nil {
        array.append(key)
      }

      dictionary[key] = newValue
    }
  }

  public subscript(index: Int) -> (KeyType, ValueType) {
    precondition(index < array.count, "index out of bounds")

    let key = array[index]
    let value = dictionary[key]!

    return (key, value)
  }

  @discardableResult
  public mutating func removeValue(forKey key: KeyType) -> ValueType? {
    if let index = array.firstIndex(of: key) {
      array.remove(at: index)
    }
    return dictionary.removeValue(forKey: key)
  }

  public mutating func removeAll(keepingCapacity: Bool = false) {
    dictionary.removeAll(keepingCapacity: keepingCapacity)
    array.removeAll(keepingCapacity: keepingCapacity)
  }
}

public extension OrderedDictionary {
  @discardableResult
  mutating func insert(_ value: ValueType, forKey key: KeyType, atIndex index: Int) -> ValueType? {
    precondition(index <= array.count, "index out of range")

    var adjustedIndex = index

    // If insert for key: b, at index 2
    //
    //        |
    //        v
    //   0    1    2
    // ["a", "b", "c"]
    //
    // Remove "b"
    //   0    1
    // ["a", "c"]

    let existingValue = dictionary[key]
    if existingValue != nil {
      let existingIndex = array.firstIndex(of: key)!
      if existingIndex < index, index >= array.count {
        adjustedIndex -= 1
      }

      array.remove(at: existingIndex)
    }
    array.insert(key, at: adjustedIndex)
    dictionary[key] = value

    return existingValue
  }

  @discardableResult
  mutating func remove(at index: Int) -> (KeyType, ValueType) {
    precondition(index < array.count, "index out of bounds")

    let key = array.remove(at: index)
    let value = dictionary.removeValue(forKey: key)

    return (key, value!)
  }
}
