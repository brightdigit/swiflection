//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public struct SLQuery {
  
  public struct from {
    
    public static var allBundles = ClosureSource(closure: NSBundle.allBundles).map{
      (object: AnyObject) -> [SLBundle] in
      let nsBundle = object as NSBundle
      let bundle = SLBundle(nsBundle: nsBundle)
      return [bundle]
    }
    
    public static var allClasses = ClosureSource{SLClass.allClasses}
  }
}