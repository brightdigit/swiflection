//
//  Source.swift
//  Swiflection
//
//  Created by Leo G Dion on 10/31/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

import Foundation


public protocol Source {
  typealias T
  //typealias Filter = (T) -> Bool
  func filter(filter: (T) -> Bool) -> Source
  //func filter(filter: Filter) -> Source
  //func map(map: Map) -> Source
}
