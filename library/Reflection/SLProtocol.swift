//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

open class SLProtocol {
  open let objc_Protocol:Protocol!
  fileprivate var _name:String?
  
  open var name:String {
    if _name == nil {
      _name = SLProtocol.getName(objc_Protocol:objc_Protocol)
    }
    return _name!
  }
  
  public init (objc_Protocol:Protocol) {
    self.objc_Protocol = objc_Protocol
  }
  
  public init?(name: String) {
    if let objc_Protocol = objc_getProtocol(name.cString) {
      self.objc_Protocol = objc_Protocol
    } else {
      return nil
    }
  }
'(AnyClass?, UnsafeMutablePointer<UInt32>?) -> AutoreleasingUnsafeMutablePointer<Protocol>?'
'(_, UnsafeMutablePointer<UInt32>) -> AutoreleasingUnsafeMutablePointer<_?>'
  open class func protocols (fromClass cls:SLClass) -> [SLProtocol] {
    return ArumpIterator(parameter: cls.class, method: class_copyProtocolList).map(SLProtocol.from)
  }
  
  open class func from(objc_Protocol: Protocol) -> SLProtocol {
    return SLProtocol(objc_Protocol: objc_Protocol)
  }
  
  open class func getName (objc_Protocol:Protocol) -> String {
    let cName = protocol_getName(objc_Protocol)
    return String(cString: cName)
  }
  
  open func isAdoptedBy(`class` slClass: SLClass) -> Bool {
    return slClass.adoptsProtocol(self)
  }
}
