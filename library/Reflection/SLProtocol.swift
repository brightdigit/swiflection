//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

open class SLProtocol : Equatable {
  public static func ==(lhs: SLProtocol, rhs: SLProtocol) -> Bool {
    return protocol_isEqual(lhs.objc_Protocol, rhs.objc_Protocol)
  }
  
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
  
  open class func protocols (fromClass cls:SLClass) -> [SLProtocol] {
    
    return ArumpSequence(parameter: cls.class, method: class_copyProtocolList)?.map(SLProtocol.from) ?? [SLProtocol]()
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
