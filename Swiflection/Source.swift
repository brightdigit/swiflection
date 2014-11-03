//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class Source<T> {
  
  public init () {
    
  }
  
  public func filter(closure: (T) -> Bool) -> Source<T> {
    return FilteredSource(source: self, filter: closure)
  }
  
  public func map<U>(closure: (T) -> [U]) -> Source<U> {
    return MapSource (source: self, map: closure)
  }
  /*
  public func map<U>(closure: (T, ([U], NSError?) -> Void)) -> Source<U> {
    return AsyncMapSource(source: self, map: closure)
  }
  */
  public func executeSync(error: NSErrorPointer) -> [T] {
    return []
  }
  
  public func execute(closure: ([T], NSError?) -> Void) {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      var error:NSError?
      var result = self.executeSync(&error)
      closure(result, error)
    })
  }
}

public class ClosureSource<T> : Source<T> {
  private var closure: (() -> [T])
  
  public init (closure: () -> [T]) {
    self.closure = closure
  }

  public override func executeSync(error: NSErrorPointer) -> [T] {
    return closure()
  }
}

public class FilteredSource<T> : Source<T> {
  private var source: Source<T>
  private var filter: (T) -> Bool
  
  public init (source: Source<T>, filter: (T) -> Bool) {
    self.source = source
    self.filter = filter
  }
  
  public override func executeSync(error: NSErrorPointer) -> [T] {
    return source.executeSync(error).filter(self.filter)
  }
}

public class MapSource<T,U> : Source<U> {
  private var source: Source<T>
  private var map: (T) -> [U]
  
  public init (source: Source<T>, map: (T) -> [U]) {
    self.source = source
    self.map = map
  }
  
  public override func executeSync(error: NSErrorPointer) -> [U] {
    return source.executeSync(error).map(self.map).reduce([]) {$0 + $1}
  }
}
/*
public class AsyncMapSource<T,U> : Source<U> {
  private var source: Source<T>
  private var map: (T, ([U], NSError?) -> Void)
  
  public init (source: Source<T>, map:(T, ([U], NSError?) -> Void)) {
    self.source = source
    self.map = map
  }
}
*/
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
  
}

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
    var ucount:UInt32 = 0
//    class_copyProtocolList(cls.objc_Class, &ucount)
    class_copyMethodList(cls.objc_Class, &ucount)
    
    var objc_Protocols_iterator = ArumpIterator(parameter: cls.objc_Class, method: class_copyProtocolList)
    //ArumpIterator(class_copyProtocolList, cls.objc_Class)// = class_copyProtocolList(cls.objc_Class, &ucount)
    return objc_Protocols_iterator.map{
      (objc_Protocol) -> SLProtocol in
      return SLProtocol(objc_Protocol:objc_Protocol)
    }
  }

  public class func getName (#objc_Protocol:Protocol) -> String {
    let cName = protocol_getName(objc_Protocol)
    return String.fromCString(cName)!
  }
}

public class SLClass {
  public let objc_Class:AnyClass
  public var _protocols:[SLProtocol]?

  public var protocols:[SLProtocol] {
    get {
      if _protocols == nil {
        _protocols = SLProtocol.protocols(fromClass: self)
      }
      return _protocols!
    }
  }
  
  public init (objc_Class : AnyClass) {
    self.objc_Class = objc_Class
  }
  
  public class func classes (fromBundle bundle:SLBundle) -> [SLClass] {
    var ucount:UInt32 = 0
    let imageName = bundle.nsBundle.executablePath!.cStringUsingEncoding(NSUTF8StringEncoding)
    let classNames = objc_copyClassNamesForImage(imageName!, &ucount)
    var classes = [SLClass]()
    let count = Int(ucount)
    //for index in 0...count {
    for var pointerIndex = 0; pointerIndex < count; pointerIndex++ {
      var current = classNames.advancedBy(pointerIndex)
      var objc_Class: AnyClass! = objc_lookUpClass(current.memory)
      classes.append(SLClass(objc_Class: objc_Class))
    }
    
    return classes
  }

  public func adoptsProtocol(#name: String) -> Bool {
    return self.protocols.some{
      (ptcl) -> Bool in
      return ptcl.name == name
    }
  }
}

extension Array {
  func every(closure: (T) -> Bool) -> Bool {
    for item in self {
      if !closure(item) {
        return false
      }
    }
    return true
  }
  
  func some(closure: (T) -> Bool) -> Bool {
    for item in self {
      if closure(item) {
        return true
      }
    }
    return false
  }
}

public class ArumpIterator<T> {
  private let pointer:AutoreleasingUnsafeMutablePointer<T?>
  private let ucount:UInt32
  
  public init (pointer: AutoreleasingUnsafeMutablePointer<T?>, count: UInt32) {
    self.pointer = pointer
    self.ucount = count
  }
  
  public init<U>(parameter: U, method: (U, UnsafeMutablePointer<UInt32>) -> AutoreleasingUnsafeMutablePointer<T?>) {
    var ucount:UInt32 = 0
    self.pointer = method(parameter, &ucount)
    self.ucount = ucount
  }

  public func map<W>(closure: (T) -> W) -> [W] {
    let count = Int(ucount)
    var result:[W] = []
    for var index = 0; index < count; index++ {
      if let item = self.pointer[index] {
        result.append(closure(item))
      }
    }
//    var current = self.pointer as Protocol?
    return result
    /*
    for var pointerIndex = 0; pointerIndex < count; pointerIndex++ {
      
      if let item = current.memory {
        result.append(closure(item))
      }
      //var objc_Class: AnyClass! = objc_lookUpClass(current.memory)
      //classes.append(SLClass(objc_Class: objc_Class))
      //      current.memory
      //var name = String.fromCString(current.memory)
      //objc_look
      //println(name)
    }
    return result
*/
  }
}

public struct SLQuery {
  
  public struct from {
    
    public static var allBundles = ClosureSource(closure: NSBundle.allBundles).map{
      (object: AnyObject) -> [SLBundle] in
      let nsBundle = object as NSBundle
      let bundle = SLBundle(nsBundle: nsBundle)
      return [bundle]
    }
  }
}

