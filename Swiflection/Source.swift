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
  public func executeSync(#error: NSErrorPointer) -> [T] {
    return []
  }
  
  public func execute(closure: ([T], NSError?) -> Void) {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      var error:NSError?
      var result = self.executeSync(error: &error)
      closure(result, error)
    })
  }
}

public class ClosureSource<T> : Source<T> {
  private var closure: (() -> [T])
  
  public init (closure: () -> [T]) {
    self.closure = closure
  }

  public override func executeSync(#error: NSErrorPointer) -> [T] {
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
  
  public override func executeSync(#error: NSErrorPointer) -> [T] {
    return source.executeSync(error: error).filter(self.filter)
  }
}

public class MapSource<T,U> : Source<U> {
  private var source: Source<T>
  private var map: (T) -> [U]
  
  public init (source: Source<T>, map: (T) -> [U]) {
    self.source = source
    self.map = map
  }
  
  public override func executeSync(#error: NSErrorPointer) -> [U] {
    return source.executeSync(error: error).map(self.map).reduce([]) {$0 + $1}
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

public class SLClass : Printable {
  public let objc_Class:AnyClass
  public var _protocols:[SLProtocol]?

  public var name:String {
    return NSStringFromClass(self.objc_Class)
  }
  
  public var description : String {
    return self.name
  }
  
  public func factory<T>() -> ()->T? {
    return {
      return nil
    }
  }
  
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

public class UmpIterator<T> {
  private let pointer:UnsafeMutablePointer<T>
  private let ucount:UInt32
  
  public init (pointer: UnsafeMutablePointer<T>, count: UInt32) {
    self.pointer = pointer
    self.ucount = count
  }
  
  public convenience init<U>(parameter: U, method: (U, UnsafeMutablePointer<UInt32>) -> UnsafeMutablePointer<T>) {
    var ucount:UInt32 = 0
    var pointer = method(parameter, &ucount)
    self.init(pointer: pointer, count: ucount)
  }
  
  public convenience init (method: (UnsafeMutablePointer<UInt32>) -> UnsafeMutablePointer<T>) {
    var ucount:UInt32 = 0
    var pointer = method(&ucount)
    self.init(pointer: pointer, count: ucount)
  }
  
  public func map<W>(closure: (T) -> W) -> [W] {
    let count = Int(ucount)
    var result:[W] = []
    for var index = 0; index < count; index++ {
      result.append(closure(pointer[index]))
    }
    return result
  }
}

public class ArumpIterator<T> {
  private let pointer:AutoreleasingUnsafeMutablePointer<T?>
  private let ucount:UInt32
  
  public init (pointer: AutoreleasingUnsafeMutablePointer<T?>, count: UInt32) {
    self.pointer = pointer
    self.ucount = count
  }
  
  public convenience init<U>(parameter: U, method: (U, UnsafeMutablePointer<UInt32>) -> AutoreleasingUnsafeMutablePointer<T?>) {
    var ucount:UInt32 = 0
    var pointer = method(parameter, &ucount)
    self.init(pointer: pointer, count: ucount)
  }
  
  public convenience init (method: (UnsafeMutablePointer<UInt32>) -> AutoreleasingUnsafeMutablePointer<T?>) {
    var ucount:UInt32 = 0
    var pointer = method(&ucount)
    self.init(pointer: pointer, count: ucount)
  }

  public func map<W>(closure: (T) -> W) -> [W] {
    let count = Int(ucount)
    var result:[W] = []
    for var index = 0; index < count; index++ {
      if let item = self.pointer[index] {
        result.append(closure(item))
      }
    }
    return result
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
    
    public static var allClasses = ClosureSource{SLClass.allClasses}
  }
}

