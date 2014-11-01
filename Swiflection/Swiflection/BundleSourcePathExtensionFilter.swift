//
//  BundleSourcePathExtensionFilter.swift
//  Swiflection
//
//  Created by Leo G Dion on 10/31/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class BundleSourcePathExtensionFilter  {
  
  let pathExtension:String
  
  public init (pathExtension: String) {
    self.pathExtension = pathExtension
  }
  
  public func filter (bundle : Bundle) -> Bool{

    return bundle.nsBundle.bundlePath.pathExtension == pathExtension
  }
}