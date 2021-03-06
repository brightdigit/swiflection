//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public struct SLQuery {
  
  public struct map {
    public static func asArray<T,U> (closure: (T)->U?) -> (T) -> [U] {
      return {
        (t) -> [U] in
        if let item = closure(t) {
          return [item]
        } else {
          return []
        }
      }
    }
  }
  public struct from {
    public static var allBundles = ClosureSource(closure: NSBundle.allBundles).map(SLQuery.map.asArray(SLBundle.fromNSBundle))
    
    public static var allFrameworks = ClosureSource(closure: NSBundle.allFrameworks).map(SLQuery.map.asArray(SLBundle.fromNSBundle))
    
    public static var allClasses = ClosureSource{SLClass.allClasses}
  }
}