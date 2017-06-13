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
  open let `class`:AnyClass
  public private(set) lazy var protocols : [SLProtocol] = {
    return SLProtocol.protocols(fromClass: self)
  }()
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
  public init (`class` : AnyClass) {
    self.class = `class`
  }
  
  public convenience init(className: CString) {
    let cls = objc_lookUpClass(className) as! AnyClass
    self.init(class: cls)
  }
  
  open class func fromClass(_ objc_Class: AnyClass) -> SLClass {
    return SLClass(class: objc_Class)
  }
  
  open class func fromClassName(_ className: CString) -> SLClass {
    return SLClass(className: className)
  }
  
  open class func classes (fromBundle bundle:SLBundle) -> [SLClass]? {
    guard let imageName = bundle.bundle.imageName else {
      return nil
    }
    
    let classIterator = UmpSequence(parameter: imageName, method: objc_copyClassNamesForImage)
    
    return classIterator?.map(SLClass.fromClassName)
  }
//
//  open class var allClasses:[SLClass] {
//    return ArumpIterator(method: objc_copyClassList).map(SLClass.from)
//  }
//  
  open func adoptsProtocol(name: String) -> Bool {
    return self.protocols.some{
      (ptcl) -> Bool in
      return ptcl.name == name
    }
  }
  
  open func adoptsProtocol(_ ptcl: Protocol) -> Bool {
    return self.protocols.some{
      (p) -> Bool in
      return protocol_isEqual(p.objc_Protocol, ptcl)
    }
  }

  open func adoptsProtocol(_ slProtocol: SLProtocol) -> Bool {
    return self.adoptsProtocol(slProtocol.objc_Protocol)
  }
//  
//  open func build() -> AnyObject {
//    let type = self.objc_Class as! NSObject.Type
//    return type.init()
//  }
}







