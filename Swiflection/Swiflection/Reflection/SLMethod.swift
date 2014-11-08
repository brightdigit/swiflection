//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class SLMethod {
  public let objc_Method:Method
  private let slClass:SLClass
  
  public var selector:Selector {
    return self._lazySelector.value
  }
  
  private let _lazySelector:Lazy<Selector>
  
  public init (objc_Method: Method, slClass: SLClass) {
    self._lazySelector = Lazy{
      () -> Selector in
      return method_getName(objc_Method)
    }
    self.slClass = slClass
    self.objc_Method = objc_Method
  }
  
  public class func methods (fromClass slClass:SLClass) -> [SLMethod] {
    var methodIterator = UmpIterator(parameter: slClass.objc_Class, method: class_copyMethodList)
    return methodIterator.map{
      (objc_Method) -> SLMethod in
      return SLMethod(objc_Method:objc_Method, slClass: slClass)
    }
  }
  
  public func closure () -> () -> AnyObject! {
    var imp = method_getImplementation(self.objc_Method)
    
    return MethodImp.closureFromImplementation(imp, fromClass: self.slClass.objc_Class, withSelector: self.selector)
  }
}