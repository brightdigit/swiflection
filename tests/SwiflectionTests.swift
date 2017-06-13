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
    let bundleIdentifier = "com.brightdigit.Sample"
    let bundle = Bundle(identifier: bundleIdentifier)!
    let url = bundle.url(forResource: "protocols", withExtension: nil)!
    let protocolText = try! String(contentsOf: url)
    let expectation = self.expectation(description: "")
    let protocolSets = protocolText.components(separatedBy: "\n").map{
      line -> (String, [String]) in
      let lineComponents = line.components(separatedBy: ": ")
      let protocolSuffix = lineComponents[0]
      let classNames = lineComponents[1].components(separatedBy: " ").map{"Class\($0)"}
      return (protocolSuffix, classNames)
    }
    bundle.reflect { (bundle) in
      for protocolSet in protocolSets {
        let protocolName = "\(bundleIdentifier).Protocol\(protocolSet.0)"
        let classNames = bundle.classes.filter{
          (cls) -> Bool in
          cls.protocols.contains(where: { (prtcl) -> Bool in
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
  
  
//  open class func classes (fromBundle bundle:Bundle) -> [AnyClass]? {
//
//    var ucount:UInt32 = 0
//    guard let imageName = bundle.imageName else {
//      return nil
//    }
//
//    guard let collection = UmpSequence(parameter: imageName, method: objc_copyClassNamesForImage) else {
//      return nil
//    }
//
//      return collection.flatMap {
//        objc_lookUpClass($0)
//      }
//  }
//      return UmpSequence<UnsafePointer<Int8>>(parameter: bundle.imageName, method: objc_copyClassNamesForImage)
//    if let imageName = bundle.imageName {
//      return UmpSequence(parameter: imageName, method: objc_copyClassNamesForImage)
//    } else {
//      return imageNames.values
//    }
  
  /*
 (UnsafePointer<Int8>, UnsafeMutablePointer<UInt32>?) -> UnsafeMutablePointer<UnsafePointer<Int8>>?'
   
 (_, UnsafeMutablePointer<UInt32>?) -> UnsafeMutablePointer<_>?'
 */
  //func testFactory() {
//    let bundle = Bundle(for: type(of: self))
//    let classes = type(of: self).classes(fromBundle: bundle)
//
//    let testA = TestProtocolA.self
//
//    let prtcl = objc_getProtocol("Swiflection_macOSTests.TestProtocolA".cString)
//    let conformsToClasses = classes?.filter{
//      class_conformsToProtocol($0, prtcl)
//    }
//
//    let item = conformsToClasses?.first as? TestProtocolA.Type
//    debugPrint(item?.build().value)
    
//    let slBundle = bundle.reflection
//    slBundle.classes.whichAdopt(
    
    //objc_getClassList(bundle, <#T##bufferCount: Int32##Int32#>)
//    var error: NSErrorPointer? = nil
//    var objs = SLQuery.from.allClasses.filter{
//      $0.adoptsProtocol(name: sampleProtocol)
//      }.map{
//      [$0.build()]
//    }.execute(error: error)
//
//    XCTAssert(objs.count < 1, "not returning valid object")
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
  

