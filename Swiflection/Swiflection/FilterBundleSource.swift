//
//  FilterBundleSource.swift
//  Swiflection
//
//  Created by Leo G Dion on 10/31/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//
/*
public class FilterBundleSource<T: Bundle, U:Source where U.T == Bundle> {
  typealias T = Bundle

  let source:U
  let filter:BundleFilter
  
  public init (source: U, filter: BundleFilter) {
    self.source = source
    self.filter = filter
  }
  
  public func filter<W:Source where W.T == Bundle>(filter: BundleFilter) -> W {
    return FilterBundleSource (source: self, filter: filter)
  }
  
}
*/
  public class FilterBundleSource : BundleSource {
    
    let source:BundleSource
    let filter:BundleFilter
    
    public init (source: BundleSource, filter: BundleFilter) {
      self.source = source
      self.filter = filter
    }
    
    public func filter (filter: BundleFilter) -> BundleSource {
      return FilterBundleSource (source: self, filter: filter)
    }
    
  }