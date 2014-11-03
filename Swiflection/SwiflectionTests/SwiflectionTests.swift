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
    }.map {
      (cls) -> [SLProtocol] in
      return cls.protocols
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
