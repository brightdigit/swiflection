//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class ClosureSource<T> : Source<T> {
  private var closure: (() -> [T])
  
  public init (closure: () -> [T]) {
    self.closure = closure
  }

  public override func executeSync(#error: NSErrorPointer) -> [T] {
    return closure()
  }
}