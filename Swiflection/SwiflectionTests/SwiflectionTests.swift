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
  let samplePrefix = "Swiflection_Sample_OSX"
  import Swiflection_Sample_OSX
#elseif os(iOS)
  import Swiflection_IOS
  let samplePrefix = "Swiflection_Sample_IOS"
  import Swiflection_Sample_IOS
#endif

let sampleLibrary = "\(samplePrefix).framework"
let sampleClass = "\(samplePrefix).SampleClass"
let sampleProtocol = "\(samplePrefix).SampleProtocolA"

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
  
  func testFactory() {
    var error: NSErrorPointer = nil
    var objs = SLQuery.from.allClasses.filter{
      $0.adoptsProtocol(name: sampleProtocol)
      }.map{
      [$0.build()]
    }.execute(error: error)
    
    XCTAssert(objs.count < 1, "not returning valid object")
    /*
    var methods = SLQuery.from.allClasses.filter{
      (slc) -> Bool in
      return slc.name == sampleClass
    }.map{
      (slc) -> [SLMethod] in
      var sel = Selector("init")
      if let method = slc.method(sel) {
        return [method]
      } else {
        return []
      }
    }.execute(error: error)
    
    var obj = methods[0].closure() as? SampleClass
*/
    //XCTAssert(obj != nil, "not returning valid object")
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
      return cls.adoptsProtocol(name: sampleProtocol)
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
