//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

open class ClosureSource<T> : Source<T> {
  fileprivate var closure: (() -> [T])
  
  public init (closure: @escaping () -> [T]) {
    self.closure = closure
  }

  open override func execute() throws -> [T] {
    return closure()
  }
}
