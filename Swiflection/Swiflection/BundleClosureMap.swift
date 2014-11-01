//
//  BundleClosureMap.swift
//  Swiflection
//
//  Created by Leo G Dion on 10/31/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

#if os(OSX)
import Cocoa
#elseif os(iOS)
import Foundation
#endif
/*
public class BundleClosureMap<U> : Map {
    typealias T = Bundle
  
  let closure: (T) -> [U]

  
  public init (closure : (Bundle) -> [U]) {
    self.closure = closure
  }
  
  public func map<T, U>(item: T) -> [U] {
    return closure(item)
  }
}
*/