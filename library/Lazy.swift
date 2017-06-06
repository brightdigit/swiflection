//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

open class Lazy<T> {
  fileprivate var _factory: () -> T
  fileprivate var _value:T?
  
  public init (factory : @escaping () -> T) {
    self._factory = factory
  }
  
  open var value:T {
    if self._value == nil {
      self._value = self._factory()
    }
    
    return _value!
  }
}
