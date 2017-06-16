//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

extension Array {
  func dictionary<K,V>(_ transformer: (Element) -> (K, V)?) -> [K:V] {
    return self.reduce([:]) {
      (dict, e) in
      guard let (key, value) = transformer(e) else
      {
        return dict
      }
      var dict = dict
      dict[key] = value
      return dict
    }
  }
}
