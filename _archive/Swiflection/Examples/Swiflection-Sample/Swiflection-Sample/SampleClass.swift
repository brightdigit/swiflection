//
//  SampleClass.swift
//  Swiflection-Sample
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//
import Foundation

@objc public protocol SampleProtocolA {
  func testA ()
}

@objc public protocol SampleProtocolB {
  func testB ()
  
}

open class SampleClass:  SampleProtocolA, SampleProtocolB{
  open func testA() {

  }
  open func testB() {

  }
  @objc public init () {
    
  }
}
