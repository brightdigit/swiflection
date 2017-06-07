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


extension String {
  public var resolvedPath : String  {
    return NSString(string: self).resolvingSymlinksInPath
  }
}
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
let imageNames = UmpSequence(method: objc_copyImageNames).map(String.init(cString:)).dictionary{ ($0.resolvedPath, $0)}

//let imageNames : [String] = UmpIterator(method: objc_copyImageNames).

extension Bundle {
    open var resolvedExecutablePath : String? {
      if let path = self.executablePath?.resolvedPath {
        return nil //imageNames[path]
      } else {
        return nil
      }
      
    }
    open var imageName : CString? {
      
      if let cls: AnyClass = self.principalClass {
        return class_getImageName(cls)
      } else if let executablePath = self.resolvedExecutablePath {
        return NSString(string: executablePath).utf8String
      } else {
        return nil
      }
    }
}

@objc protocol TestProtocolA {
  
}

class TestClassA : TestProtocolA {
  
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
  
  open class func classes (fromBundle bundle:Bundle) -> [AnyClass]? {
    var ucount:UInt32 = 0
    guard let imageName = bundle.imageName else {
      return nil
    }
    
    guard let collection = UmpSequence(parameter: imageName, method: objc_copyClassNamesForImage) else {
      return nil
    }
    
      return collection.flatMap {
        objc_lookUpClass($0)
      }
  }
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
  func testFactory() {
    let bundle = Bundle(for: type(of: self))
    let classes = type(of: self).classes(fromBundle: bundle)
    
    let testA = TestProtocolA.self
    
    let prtcl = objc_getProtocol("Swiflection_macOSTests.TestProtocolA".cString)
    let conformsToClasses = classes?.filter{
      class_conformsToProtocol($0, prtcl)
    }
    debugPrint(conformsToClasses)
    
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
  
//  func testLoadLibrary() {
//    var expectation = self.expectation(description: "expectation")
//    var query = SLQuery.from.allBundles.filter{
//      (bundle) -> Bool in
//      return bundle.nsBundle.bundlePath.pathExtension == "xctest"
//    }.map{
//      (bundle) -> [String] in
//      return [bundle.nsBundle.bundlePath.stringByDeletingLastPathComponent]
//    }.map{
//      (directory) -> [SLBundle] in
//      let bundlePath = directory.stringByAppendingPathComponent(sampleLibrary)
//      let bundle = SLBundle(path: bundlePath)
//      if bundle != nil {
//        return [bundle!]
//      } else {
//        return []
//      }
//    }.map{
//      (bundle) -> [SLClass] in
//      return bundle.classes
//    }.filter {
//      (cls) -> Bool in
//      return cls.adoptsProtocol(name: sampleProtocol)
//    }.map{
//      (cls) -> [SLProtocol] in
//      return cls.protocols
//    }.map{
//      (ptl) -> [String] in
//      return [ptl.name]
//    }
//    
//    query.execute{
//      (protocols, error) in
//      println(protocols)
//      XCTAssert(protocols.count == 2)
//      expectation.fulfill()
//    }
//    
//    self.waitForExpectations(withTimeout: 10, handler: {
//      error in
//      println(error)
//    })  }
  
}
