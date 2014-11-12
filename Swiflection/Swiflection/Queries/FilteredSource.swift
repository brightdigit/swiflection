//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class FilteredSource<T> : Source<T> {
  private var source: Source<T>
  private var filter: (T) -> Bool
  
  public init (source: Source<T>, filter: (T) -> Bool) {
    self.source = source
    self.filter = filter
  }
  
  public override func execute(#error: NSErrorPointer) -> [T] {
    return source.execute(error: error).filter(self.filter)
  }
}