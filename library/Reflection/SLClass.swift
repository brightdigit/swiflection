//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

open class SLClass: CustomStringConvertible {
  open let `class`: AnyClass
  
  public private(set) lazy var protocols : [SLProtocol] = {
    return SLProtocol.protocols(fromClass: self)
  }()
  
  open var name:String {
    return NSStringFromClass(self.class)
  }
  
  public var description: String {
    return self.name
  }
  
  public init (`class` : AnyClass) {
    self.class = `class`
  }
  
  public convenience init(className: CString) {
    let cls : AnyClass = objc_lookUpClass(className)!
    self.init(class: cls)
  }
  
  open class func classes (fromBundle bundle:SLBundle) -> [SLClass]? {
    guard let imageName = bundle.bundle.imageName else {
      return nil
    }
    
    let classIterator = UmpSequence(parameter: imageName, method: objc_copyClassNamesForImage)
    
    return classIterator?.map(SLClass.init(className:))
  }

  open func adoptsProtocol(_ slProtocol: SLProtocol) -> Bool {
    return self.protocols.contains(slProtocol)
  }
}







