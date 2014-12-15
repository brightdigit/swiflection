//
//  Factory.swift
//  Swiflection
//
//  Created by Leo G Dion on 11/13/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation
/*
public class Builder {
/*
  SLQuery.from.allFrameworks.filter(isSystemBundle).map(SLClass.classes).filter(SLProtocol.from(objc_Protocol: sdb_framework.ConfigurationParser).isAdoptedBy).execute(error: nil).first?.method("init")?.closure() as? sdb_framework.ConfigurationParser
*/
  public init () {

  }
  public func buildObject(whichAdoptsProtocol objc_Protocol: Protocol, fromFrameworksWhich filter: (SLBundle) -> Bool) -> AnyObject?  {
       let method = SLQuery.from.allFrameworks.filter(filter).map(SLClass.classes).filter(SLProtocol.from(objc_Protocol: objc_Protocol).isAdoptedBy).execute(error: nil).first?.method("init")//.closure()

      return method?.closure()
  
  }
  public func buildObject(whichAdoptsProtocol objc_Protocol: Protocol, fromBundleIdentifier bundleId: String) -> AnyObject?  {
    let method = SLBundle(identifier: bundleId)?.classes.filter(SLProtocol.from(objc_Protocol: objc_Protocol).isAdoptedBy).first?.method("init")

      return method?.closure()
  
  }
}
*/