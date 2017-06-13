//
//  SwiflectionTests.swift
//  SwiflectionTests
//
//  Created by Leo G Dion on 10/31/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import XCTest
import Foundation
@testable import Swiflection



//#if os(OSX)
//import Swiflection_OSX
//  let samplePrefix = "Swiflection_Sample_OSX"
//#elseif os(iOS)
//  import Swiflection_IOS
//  let samplePrefix = "Swiflection_Sample_IOS"
//#endif
//
//let sampleLibrary = "\(samplePrefix).framework"
//let sampleClass = "\(samplePrefix).SampleClass"
//let sampleProtocol = "\(samplePrefix).SampleProtocolA"
//


//let imageNames : [String] = UmpIterator(method: objc_copyImageNames).


@objc protocol TestProtocolA  {
  var value:String { get }
  static func build () -> TestProtocolA
}

class TestClassA : TestProtocolA {
  static func build() -> TestProtocolA {
    return TestClassA()
  }
  
  let value  = "test"
  
}

class SwiflectionTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    // This is an example of a functional test case.
    XCTAssert(true, "Pass")
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure() {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testFactory() {
    let bundle = Bundle!(path: "Sample.framework")
  }
  
}
