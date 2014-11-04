//
//  SampleClass.swift
//  Swiflection-Sample
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

@objc public protocol SampleProtocolA {
  func testA ()
}

@objc public protocol SampleProtocolB {
  func testB ()
  
}

public class SampleClass:  SampleProtocolA, SampleProtocolB{
  public func testA() {

  }
  public func testB() {

  }
  @objc public init () {
    
  }
}
