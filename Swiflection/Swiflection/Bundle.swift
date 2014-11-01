//
//  Bundle.swift
//  Swiflection
//
//  Created by Leo G Dion on 10/31/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

#if os(OSX)
import Cocoa
#elseif os(iOS)
import Foundation
#endif

public class Bundle {
  let nsBundle:NSBundle
  
  public init (nsBundle: NSBundle) {
    self.nsBundle = nsBundle
  }
}

public typealias BundleFilter = (Bundle) -> Bool

public protocol BundleSource {
  //typealias T = Bundle
  func filter(filter: (Bundle) -> Bool) -> BundleSource
  //func map<U>(map: (Bundle) -> [U]) -> AnyObject
  //func map<T>(map: (Bundle) -> [T])
}
