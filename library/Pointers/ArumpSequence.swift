//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

open class ArumpSequence<T> : BidirectionalCollection {
  
  
  private let pointer:AutoreleasingUnsafeMutablePointer<T>
  private let ucount:UInt32
  
  public typealias Element = T
  public typealias Index = UInt32
  
  public init (pointer: AutoreleasingUnsafeMutablePointer<T>, count: UInt32) {
    self.pointer = pointer
    self.ucount = count
  }
  
  public convenience init?<U>(parameter: U, method: (U, UnsafeMutablePointer<UInt32>?) -> AutoreleasingUnsafeMutablePointer<T>?) {
    var ucount:UInt32 = 0
    guard let pointer = method(parameter, &ucount) else {
      return nil
    }
    
    self.init(pointer: pointer, count: ucount)
  }
  
  public subscript (position: Index) -> T {
    precondition(self.indices.contains(position), "out of bounds")
    return pointer[Int(position)]
  }
  
  public func index(before i: UInt32) -> UInt32 {
    return i-1
  }
  
  public func index(after i: UInt32) -> UInt32 {
    return i+1
  }
  
  public let startIndex: UInt32 = 0
  
  public var endIndex: UInt32 {
    return self.ucount
  }
  
}
