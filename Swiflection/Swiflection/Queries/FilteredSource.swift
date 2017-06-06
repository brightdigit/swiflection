//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

open class FilteredSource<T> : Source<T> {
  fileprivate var source: Source<T>
  fileprivate var filter: (T) -> Bool
  
  public init (source: Source<T>, filter: @escaping (T) -> Bool) {
    self.source = source
    self.filter = filter
  }
  
  open override func execute() throws -> [T] {
    return try source.execute().filter(self.filter)
  }
}
