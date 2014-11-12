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
  id (*factoryImp)(id, SEL) = (void *) implementation;
  return ^(){
    id result = factoryImp([cls alloc], selector);
    return result;
  };
}
@end
