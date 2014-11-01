//
//  AllBundleSource.swift
//  Swiflection
//
//  Created by Leo G Dion on 10/31/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//


public class AllBundleSource : BundleSource {
  typealias T = Bundle
  
  public init () {
    
  }
  
  public func filter (filter : (Bundle) -> Bool) -> BundleSource {
    return FilterBundleSource(source: self, filter: filter)
  }
}