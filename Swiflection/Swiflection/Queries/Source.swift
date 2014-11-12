//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class Source<T> {
  
  public init () {
    
  }
  
  public func filter(closure: (T) -> Bool) -> Source<T> {
    return FilteredSource(source: self, filter: closure)
  }
  
  public func map<U>(closure: (T) -> [U]) -> Source<U> {
    return MapSource (source: self, map: closure)
  }
  /*
  public func map<U>(closure: (T, ([U], NSError?) -> Void)) -> Source<U> {
    return AsyncMapSource(source: self, map: closure)
  }
  */
  public func execute(#error: NSErrorPointer) -> [T] {
    return []
  }
  
  public func execute(closure: ([T], NSError?) -> Void) {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      var error:NSError?
      var result = self.execute(error: &error)
      closure(result, error)
    })
  }
}
