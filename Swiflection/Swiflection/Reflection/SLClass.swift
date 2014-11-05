//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class SLClass : Printable {
  public let objc_Class:AnyClass
  private var _protocols:[SLProtocol]?
  private let _methods:Lazy<[SLMethod]>!
  
  public var name:String {
    return NSStringFromClass(self.objc_Class)
  }
  
  public var description : String {
    return self.name
  }
  
  public func factory<T>() -> ()->T? {
    return {
      //closureFromImplementation(<#implementation: Int32#>)
      return nil
    }
  }
  
  public var methods:[SLMethod] {
    return _methods.value
  }
  
  public var protocols:[SLProtocol] {
    get {
      if _protocols == nil {
        _protocols = SLProtocol.protocols(fromClass: self)
      }
      return _protocols!
    }
  }
  
  public func method (selector: Selector) -> SLMethod? {
    for method in self.methods {
      if (method.selector == selector) {
        return method
      }
    }
    return nil
  }
  
  public init (objc_Class : AnyClass) {
    self.objc_Class = objc_Class
    self._methods = Lazy{
      UmpIterator(parameter: objc_Class, method: class_copyMethodList).map{
        (objc_Method) -> SLMethod in
        return SLMethod(objc_Method: objc_Method, slClass: self)
      }
    }
  }
  
  public class func from(#objc_Class: AnyClass) -> SLClass {
    return SLClass(objc_Class: objc_Class)
  }
  
  public class func classes (fromBundle bundle:SLBundle) -> [SLClass] {
    var ucount:UInt32 = 0
    let imageName = bundle.nsBundle.executablePath!.cStringUsingEncoding(NSUTF8StringEncoding)!
    #if true
      let classNames = objc_copyClassNamesForImage(imageName, &ucount)
      let classIterator = UmpIterator(pointer: classNames, count: ucount)
      #else
      let classIterator = UmpIterator(parameter: imageName, method: objc_copyClassNamesForImage)
    #endif
    return classIterator.map{
      (pointer) -> SLClass in
      var cls:AnyClass! = objc_lookUpClass(pointer)
      return SLClass(objc_Class: cls)
    }
  }
  
  public class var allClasses:[SLClass] {
    return ArumpIterator(method: objc_copyClassList).map(SLClass.from)
  }
  
  public func adoptsProtocol(#name: String) -> Bool {
    return self.protocols.some{
      (ptcl) -> Bool in
      return ptcl.name == name
    }
  }
}







