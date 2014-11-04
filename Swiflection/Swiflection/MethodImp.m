//
//  MethodImp.m
//  Swiflection
//
//  Created by Leo G Dion on 11/4/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

#import "MethodImp.h"

@implementation MethodImp
+ (factory) closureFromImplementation: (IMP) implementation fromClass:(id)cls withSelector: (SEL) selector {
  id (*factoryImp)(id, SEL, id,...) = (void *) implementation;
  return ^(NSArray * parameters){
    return factoryImp([cls alloc], selector, parameters);
  };
}
@end
