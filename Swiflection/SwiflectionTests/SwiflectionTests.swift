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
#elseif os(iOS)
import Swiflection_IOS
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
//    XCTestExpectation *documentOpenExpectation = [self expectationWithDescription:@"document open"];
    var expectation = self.expectationWithDescription("expectation")
    var query = From.allBundles.filter{
      (bundle) -> Bool in
      return bundle.nsBundle.bundlePath.pathExtension == "xctest"
    }.map{
      (bundle) -> [String] in
      return [bundle.nsBundle.bundlePath.stringByDeletingLastPathComponent]
    }.map{
      (directory) -> [Bundle] in
      let bundlePath = directory.stringByAppendingPathComponent("Swiflection_Sample_OSX.framework")
      if let bundle = Bundle(path: bundlePath) {
        return [bundle]
      } else {
        return []
      }
    }.map{
      (bundle) -> [Class] in
      return bundle.classes
    }
    
    query.execute{
      (error, classes) in
      println(classes)
      expectation.fulfill()
    }
    
    self.waitForExpectationsWithTimeout(1, handler: {
      error in
      println(error)
    })
    //var filter = B
    //var xctestBundleSource = AllBundleSource().filter(BundleSourcePathExtensionFilter(pathExtension: "xctest").filter)
    /*
    var xcTestDirectoryQuery = From.allBundles().filter{
      (Bundle) in
      return Bundle.nsBundle.pathExtension == "xctest"
      }.select{
        (Bundle) in
        return Bundle.nsBundle.path.stringByDeletingLastPathComponent
    }
    
    var classQuery = From.query(xcTestDictionaryQuery).select{
      (directoryPath) in
      return Bundle(directoryPath.stringByAppendingPathComponent("Swiflection_Sample_OSX.framework"))
      }.select{
        (Bundle) in
        return Bundle.Classes
    }
    
    classQuery.execute{
      (error, classes) in
      
    }
*/
    //xctestBundleSource.map(BundleClosureMap({
    /*
    var query = xctestBundleSource.select{
      (bundle) in
      return bundle.nsBundle.path.stringByDeletingLastPathComponent.stringByAppendingPathComponent("Swiflection_Sample_OSX.framework")
    }
    var bundleSource = QueryBundleSource(query: query, {
      (path) in
      return PathBundleSource(path)
    })
    var classSource = BundleClassSource(bundleSource)
    var classQuery = classSource.select()
    classQuery.fetch{
      (results, error) in
      println(result)
    }
*/
    /*
    var frameworks = NSBundle.allBundles().filter{
      (obj) in
      if let bundle = obj as? NSBundle {
        return bundle.bundlePath.pathExtension == "xctest"
      } else {
        return false
      }
    }
    var folder = frameworks.first!.bundlePath.stringByDeletingLastPathComponent
    var sampleBundlePath = folder.stringByAppendingPathComponent("Swiflection_Sample_OSX.framework")
    //var bundleQuery = BundleQuery()
    var path
    //var bundle = NSBundle(path: sampleBundlePath)
    //bundle!.load()
    */
  }
  
}
