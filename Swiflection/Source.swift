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
public class Bundle {
  public let nsBundle:NSBundle!

  public var classes:[Class] {
    var count:UInt32 = 0
    var imageName = self.nsBundle.executablePath!.cStringUsingEncoding(NSUTF8StringEncoding)
    var classNames = objc_copyClassNamesForImage(imageName!, &count)
    for index in 0...count {
      var pointerIndex = Int(index)
      var current = classNames.advancedBy(pointerIndex)
      //      current.memory
      var name = String.fromCString(current.memory)
      println(name)
    }

    return []
  }

  public init (nsBundle: NSBundle) {
    self.nsBundle = nsBundle
  }
  
  public init? (path: String) {
    let nsBundle = NSBundle(path: path)
    if nsBundle == nil {
      return nil
    }
    self.nsBundle = nsBundle!
  }
}

public class Class {

}

public struct From {

  public static var allBundles = ClosureSource(closure: NSBundle.allBundles).map{
    (object: AnyObject) -> [Bundle] in
    let nsBundle = object as NSBundle
    let bundle = Bundle(nsBundle: nsBundle)
    return [bundle]
  }
}

