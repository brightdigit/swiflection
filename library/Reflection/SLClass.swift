//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

extension String {
  public var resolvedPath : String  {
    return NSString(string: self).resolvingSymlinksInPath
  }
}

open class SLClass /*: CustomStringConvertible */{
//  open let objc_Class:AnyClass
//  fileprivate var _protocols:Lazy<[SLProtocol]>!
//  
//  open var name:String {
//    return NSStringFromClass(self.objc_Class)
//  }
//  
//  open var description : String {
//    return self.name
//  }
//  
//  open var protocols:[SLProtocol] {
//    return self._protocols.value
//  }
//  
//  public init (objc_Class : AnyClass) {
//    self.objc_Class = objc_Class
//    self._protocols = Lazy{
//       SLProtocol.protocols(fromClass: self)
//    }
//  }
//  
//  public convenience init (className: CString) {
//    let cls:AnyClass! = objc_lookUpClass(className)
//    self.init(objc_Class: cls)
//  }
//  
//  open class func from(objc_Class: AnyClass) -> SLClass {
//    return SLClass(objc_Class: objc_Class)
//  }
//  
//  open class func from(className: CString) -> SLClass {
//    return SLClass(className: className)
//  }
//  
  open class func classes (fromBundle bundle:SLBundle) -> [SLClass]? {
    var ucount:UInt32 = 0
    
    guard let imageName = bundle.bundle.imageName else {
      return nil
    }
    
    let classIterator = UmpSequence(parameter: imageName, method: objc_copyClassNamesForImage)
    
    return classIterator.map(SLClass.from)
  }
//
//  open class var allClasses:[SLClass] {
//    return ArumpIterator(method: objc_copyClassList).map(SLClass.from)
//  }
//  
//  open func adoptsProtocol(name: String) -> Bool {
//    return self.protocols.some{
//      (ptcl) -> Bool in
//      return ptcl.name == name
//    }
//  }
//  
//  open func adoptsProtocol(_ ptcl: Protocol) -> Bool {
//    return self.protocols.some{
//      (p) -> Bool in
//      return protocol_isEqual(p.objc_Protocol, ptcl)
//    }
//  }
//  
//  open func adoptsProtocol(_ slProtocol: SLProtocol) -> Bool {
//    return self.adoptsProtocol(slProtocol.objc_Protocol)
//  }
//  
//  open func build() -> AnyObject {
//    let type = self.objc_Class as! NSObject.Type
//    return type.init()
//  }
}







