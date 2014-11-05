//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class UmpIterator<T> {
  private let pointer:UnsafeMutablePointer<T>
  private let ucount:UInt32
  
  public init (pointer: UnsafeMutablePointer<T>, count: UInt32) {
    self.pointer = pointer
    self.ucount = count
  }
  
  public convenience init<U>(parameter: U, method: (U, UnsafeMutablePointer<UInt32>) -> UnsafeMutablePointer<T>) {
    var ucount:UInt32 = 0
    var pointer = method(parameter, &ucount)
    self.init(pointer: pointer, count: ucount)
  }
  
  public convenience init (method: (UnsafeMutablePointer<UInt32>) -> UnsafeMutablePointer<T>) {
    var ucount:UInt32 = 0
    var pointer = method(&ucount)
    self.init(pointer: pointer, count: ucount)
  }
  
  public func map<W>(closure: (T) -> W) -> [W] {
    let count = Int(ucount)
    var result:[W] = []
    for var index = 0; index < count; index++ {
      result.append(closure(pointer[index]))
    }
    return result
  }
  
  deinit {
    free(self.pointer)
  }
}