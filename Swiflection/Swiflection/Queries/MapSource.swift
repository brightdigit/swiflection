//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class MapSource<T,U> : Source<U> {
  private var source: Source<T>
  private var map: (T) -> [U]
  
  public init (source: Source<T>, map: (T) -> [U]) {
    self.source = source
    self.map = map
  }
  
  public override func executeSync(#error: NSErrorPointer) -> [U] {
    return source.executeSync(error: error).map(self.map).reduce([]) {$0 + $1}
  }
}