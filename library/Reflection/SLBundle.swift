//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

//let imageNames = UmpIterator(method: objc_copyImageNames).map(String.init(cString:)).filter{ $0 != nil}.dictionary{ ($0!.stringByResolvingSymlinksInPath, $0!) }

public extension Bundle {
  public func reflect (_ closure: (SLBundleProtocol) -> Void) {
    let slBundle = SLBundle(bundle: self)
    closure(slBundle)
  }
  
  open var resolvedExecutablePath : String? {
    if let path = self.executablePath?.resolvedPath {
      return nil //imageNames[path]
    } else {
      return nil
    }
    
  }
  open var imageName : CString? {
    
    if let cls: AnyClass = self.principalClass {
      return class_getImageName(cls)
    } else if let executablePath = self.resolvedExecutablePath {
      return NSString(string: executablePath).utf8String
    } else {
      return nil
    }
  }
}

public protocol SLBundleProtocol {
  var classes : [SLClass] { get }
}

public struct SLBundle : SLBundleProtocol {
  public let bundle:Bundle
  
  public var classes: [SLClass] {
    return SLClass.classes(fromBundle: self)
  }
//  fileprivate var _classes:[SLClass]?
//
//  open var classes:[SLClass] {
//    get {
//      if _classes == nil {
//        _classes = SLClass.classes(fromBundle: self)
//      }
//      return _classes!
//    }
//  }
//
  public init (bundle: Bundle) {
    self.bundle = bundle
    
  }
//
//  public init? (path: String) {
//    let nsBundle = Bundle(path: path)
//    if nsBundle == nil {
//      return nil
//    }
//    nsBundle!.load()
//    self.nsBundle = nsBundle!
//  }
//  
//  public init? (identifier: String) {
//    let nsBundle = Bundle(identifier: identifier)
//    if nsBundle == nil {
//      return nil
//    }
//    nsBundle!.load()
//    self.nsBundle = nsBundle!
//    
//  }
//  
//  open class func fromNSBundle (_ bundle: AnyObject) -> SLBundle? {
//    if let nsBundle = bundle as? Bundle {
//      return SLBundle(nsBundle: nsBundle)
//    } else {
//      return nil
//    }
//  }
//  
//  open var resolvedExecutablePath : String? {
//    if let path = self.nsBundle.executablePath?.stringByResolvingSymlinksInPath {
//      return imageNames[path]
//    } else {
//      return nil
//    }
//  }
//  
//  open var imageName : CString {
//    if let cls: AnyClass = self.nsBundle.principalClass {
//      return class_getImageName(cls)
//    } else if let executablePath = self.resolvedExecutablePath {
//      return NSString(string: executablePath).utf8String!
//    } else {
//      return CString.null()
//    }
//  }
}

