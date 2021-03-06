//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class Lazy<T> {
  private var _factory: () -> T
  private var _value:T?
  
  public init (factory : () -> T) {
    self._factory = factory
  }
  
  public var value:T {
    if self._value == nil {
      self._value = self._factory()
    }
    
    return _value!
  }
}