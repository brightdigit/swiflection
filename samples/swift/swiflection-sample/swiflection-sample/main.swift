//
//  main.swift
//  swiflection-sample
//
//  Created by Leo G Dion on 12/10/14.
//  Copyright (c) 2014 BrightDigit. All rights reserved.
//

import Foundation

// find class which implements MyProtocol
var classes = [AnyClass]()

if let prtcl = objc_getProtocol("MyProtocol".cStringUsingEncoding(NSUTF8StringEncoding)) {
  var ucount:UInt32 = 0
  let classListPointer = objc_copyClassList(&ucount)
  let count = Int(ucount)
  
  for var index = 0; index < count; ++index {
    if let cls: AnyClass = classListPointer[index] {
      if class_conformsToProtocol(cls, prtcl) {
        classes.append(cls)
      }
    }
  }
}

// instatiate it
let instance = Bridge.alloc(classes[0]) as MyProtocol

/*
  if we already knew the class
  let instance = MyClass()
*/

// use it
instance.helloWorld()

