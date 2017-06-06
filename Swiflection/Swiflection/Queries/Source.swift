//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

open class Source<T> {
  
  public init () {
    
  }
  
  open func filter(_ closure: @escaping (T) -> Bool) -> Source<T> {
    return FilteredSource(source: self, filter: closure)
  }
  
  open func map<U>(_ closure: @escaping (T) -> [U]) -> Source<U> {
    return MapSource (source: self, map: closure)
  }
  /*
   public func map<U>(closure: (T, ([U], NSError?) -> Void)) -> Source<U> {
   return AsyncMapSource(source: self, map: closure)
   }
   */
  open func execute() throws -> [T] {
    return []
  }
  
  open func execute(_ closure: @escaping ([T]?, Error?) -> Void) {
    DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
      let error: Error?
      let result : [T]?
      do {
        result = try self.execute()
        error = nil
      } catch let _error {
        error = _error
        result = nil
      }
      closure(result, error)
    })
  }
}
