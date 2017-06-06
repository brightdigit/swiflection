//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

open class MapSource<T,U> : Source<U> {
  fileprivate var source: Source<T>
  fileprivate var map: (T) -> [U]
  
  public init (source: Source<T>, map: @escaping (T) -> [U]) {
    self.source = source
    self.map = map
  }
  
  open override func execute() throws -> [U] {
    return try source.execute().map(self.map).reduce([]) {$0 + $1}
  }
}
