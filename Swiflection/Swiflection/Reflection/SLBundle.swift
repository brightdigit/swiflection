//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/2/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation

public class SLBundle {
  public let nsBundle:NSBundle!
  private var _classes:[SLClass]?

  public var classes:[SLClass] {
    get {
      if _classes == nil {
        _classes = SLClass.classes(fromBundle: self)
      }
      return _classes!
    }
  }

  public init (nsBundle: NSBundle) {
    self.nsBundle = nsBundle
  }
  
  public init? (path: String) {
    let nsBundle = NSBundle(path: path)
    if nsBundle == nil {
      return nil
    }
    nsBundle!.load()
    self.nsBundle = nsBundle!
  }
  
}