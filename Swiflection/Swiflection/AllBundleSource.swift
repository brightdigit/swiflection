//
//  AllBundleSource.swift
//  Swiflection
//
//  Created by Leo G Dion on 10/31/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

public class AllBundleSource : BundleSource {
  public init () {
    
  }
  
  public func filter (filter : BundleFilter) -> BundleSource {
    return FilterBundleSource(source: self, filter: filter)
  }
}
