//
//  String.cString.swift
//  Swiflection
//
//  Created by Leo G Dion on 12/15/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public typealias CString = UnsafePointer<Int8>

public extension String {
  public var cString : CString {
    return NSString(string: self).utf8String!
  }
}

extension String {
  public var resolvedPath : String  {
    return NSString(string: self).resolvingSymlinksInPath
  }
}
