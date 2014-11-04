//
//  SwiflectionTests.swift
//  SwiflectionTests
//
//  Created by Leo G Dion on 10/31/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import XCTest
#if os(OSX)
import Swiflection_OSX
  let sampleLibrary = "Swiflection_Sample_OSX.framework"
#elseif os(iOS)
import Swiflection_IOS
  let sampleLibrary = "Swiflection_Sample_IOS.framework"
  import Swiflection_Sample_IOS
#endif

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
    self.measureBlock() {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testMethod() {
    var error: NSErrorPointer = nil
    
    var methods = SLQuery.from.allClasses.filter{
      (slc) -> Bool in
      return slc.name == "Swiflection_Sample_IOS.SampleClass"
    }.map{
      (slc) -> [SLMethod] in
      var sel = Selector("init")
      if let method = slc.method(sel) {
        return [method]
      } else {
        return []
      }
    }.executeSync(error: error)
    
    var obj = methods[0].closure()([]) as? SampleClass
    XCTAssert(obj != nil, "not returning valid object")
  }
  
  func testLoadLibrary() {
    var expectation = self.expectationWithDescription("expectation")
    var query = SLQuery.from.allBundles.filter{
      (bundle) -> Bool in
      return bundle.nsBundle.bundlePath.pathExtension == "xctest"
    }.map{
      (bundle) -> [String] in
      return [bundle.nsBundle.bundlePath.stringByDeletingLastPathComponent]
    }.map{
      (directory) -> [SLBundle] in
      let bundlePath = directory.stringByAppendingPathComponent(sampleLibrary)
      let bundle = SLBundle(path: bundlePath)
      if bundle != nil {
        return [bundle!]
      } else {
        return []
      }
    }.map{
      (bundle) -> [SLClass] in
      return bundle.classes
    }.filter {
      (cls) -> Bool in
      return cls.adoptsProtocol(name: "Swiflection_Sample_IOS.SampleProtocolA")
    }.map{
      (cls) -> [SLProtocol] in
      return cls.protocols
    }.map{
      (ptl) -> [String] in
      return [ptl.name]
    }
    
    query.execute{
      (protocols, error) in
      println(protocols)
      XCTAssert(protocols.count == 2)
      expectation.fulfill()
    }
    
    self.waitForExpectationsWithTimeout(10, handler: {
      error in
      println(error)
    })  }
  
}
