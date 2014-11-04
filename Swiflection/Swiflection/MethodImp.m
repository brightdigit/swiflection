//
//  MethodImp.m
//  Swiflection
//
//  Created by Leo G Dion on 11/3/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Swiflection.h"

static factory closureFromImplementation (IMP implementation) {
  id (*factoryImp)() = (void *) implementation;
  return ^{
    return factoryImp();
  };
}