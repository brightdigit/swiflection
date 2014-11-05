//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class SLProtocol {
  public let objc_Protocol:Protocol
  private var _name:String?
  
  public var name:String {
    if _name == nil {
      _name = SLProtocol.getName(objc_Protocol:objc_Protocol)
    }
    return _name!
  }
  
  public init (objc_Protocol:Protocol) {
    self.objc_Protocol = objc_Protocol
  }
  
  public class func protocols (fromClass cls:SLClass) -> [SLProtocol] {
    return ArumpIterator(parameter: cls.objc_Class, method: class_copyProtocolList).map(SLProtocol.from)
  }
  
  public class func from(#objc_Protocol: Protocol) -> SLProtocol {
    return SLProtocol(objc_Protocol: objc_Protocol)
  }
  
  public class func getName (#objc_Protocol:Protocol) -> String {
    let cName = protocol_getName(objc_Protocol)
    return String.fromCString(cName)!
  }
}