//
//  BundleFilter.swift
//  Swiflection
//
//  Created by Leo G Dion on 10/31/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

public protocol BundleFilter {
  func filter (bundle: Bundle) -> Bool
}