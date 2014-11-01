//
//  Class.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/1/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

public class Class {

}

public protocol ClassSource {
  func filter(filter: (Class) -> Bool) -> ClassSource
  
}

public class BundleClassSource<T> : ClassSource {
  let source:BundleSource
  let map: (Bundle) -> [Class]
  public init (source: BundleSource, map: (Bundle) -> [Class]) {
    self.source = source
    self.map = map
  }
  public func filter(filter: (Class) -> Bool) -> ClassSource {
    return FilteredClassSource(source: self, filter: filter)
  }
}

public class FilteredClassSource : ClassSource {
  
  let source:ClassSource
  let filter:(Class) -> Bool
  
  public init (source: ClassSource, filter: (Class) -> Bool) {
    self.source = source
    self.filter = filter
  }
  
  public func filter (filter: (Class) -> Bool) -> ClassSource {
    return FilteredClassSource (source: self, filter: filter)
  }
  
}