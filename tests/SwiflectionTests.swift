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
    let imageNames = UmpSequence(method: objc_copyImageNames).map(String.init(cString:))
    print(imageNames)
    let bundleIdentifier = "com.brightdigit.Sample"
    let moduleName = bundleIdentifier.components(separatedBy: ".").last!
    let bundle = Bundle(identifier: bundleIdentifier)!
    
    let url = bundle.url(forResource: "protocols", withExtension: nil)!
    let protocolText = try! String(contentsOf: url)
    let expectation = self.expectation(description: "")
    let protocolSets = protocolText.components(separatedBy: "\n").map{
      line -> (String, [String]) in
      let lineComponents = line.components(separatedBy: ": ")
      let protocolSuffix = lineComponents[0]
      let classNames = lineComponents[1].components(separatedBy: " ").map{"\(moduleName).Class\($0)"}
      return (protocolSuffix, classNames)
    }
    bundle.reflect { (bundle) in
      for protocolSet in protocolSets {
        let protocolName = "\(moduleName).Protocol\(protocolSet.0)"
        let classNames = bundle.classes.filter{
          (cls) -> Bool in
          cls.protocols.contains(where: { (prtcl) -> Bool in
            print(prtcl.name, protocolName)
            return prtcl.name == protocolName
          })
          }.map{ NSStringFromClass($0.class) }
        XCTAssertEqual(protocolSet.1, classNames)
      }
      expectation.fulfill()
     }
    self.waitForExpectations(timeout: 10.0) { (error) in
      XCTAssertNil(error)
    }
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure() {
      // Put the code you want to measure the time of here.
    }
  }
}
  

