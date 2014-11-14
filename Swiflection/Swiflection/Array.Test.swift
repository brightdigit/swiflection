//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

extension Array {
  func every(closure: (T) -> Bool) -> Bool {
    for item in self {
      if !closure(item) {
        return false
      }
    }
    return true
  }
  
  func some(closure: (T) -> Bool) -> Bool {
    for item in self {
      if closure(item) {
        return true
      }
    }
    return false
  }
  
  func dictionary<K,V>(transformer: T -> (K, V)?) -> [K:V] {
    return self.reduce([:]) {
      (var dict, e) in
      if let (key, value) = transformer(e)
      {
        dict[key] = value
      }
      return dict
    }
  }
}