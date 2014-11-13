//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public typealias CString = UnsafePointer<Int8>

public extension String {
  public var cString : CString {
    return NSString(string: self).UTF8String
  }
  
  func beginsWith (prefix: String) -> Bool {
    return self.hasPrefix(prefix)
  }
}

public class SLBundle {
  public let nsBundle:NSBundle!
  private var _classes:[SLClass]?

  public var classes:[SLClass] {
    get {
      if _classes == nil {
        _classes = SLClass.classes(fromBundle: self)
      }
      return _classes!
    }
  }

  public init (nsBundle: NSBundle) {
    self.nsBundle = nsBundle
  }
  
  public init? (path: String) {
    let nsBundle = NSBundle(path: path)
    if nsBundle == nil {
      return nil
    }
    nsBundle!.load()
    self.nsBundle = nsBundle!
  }
  
  public class func fromNSBundle (bundle: AnyObject) -> SLBundle? {
    if let nsBundle = bundle as? NSBundle {
      return SLBundle(nsBundle: nsBundle)
    } else {
      return nil
    }
  }
  
  public var imageName : CString {
    if let cls: AnyClass = self.nsBundle.principalClass {
      return class_getImageName(cls)
    } else if let executablePath = self.nsBundle.executablePath {
      return NSString(string: executablePath).UTF8String
    } else {
      return CString.null()
    }
  }
  
}