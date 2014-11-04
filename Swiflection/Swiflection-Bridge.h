//
//  Swiflection.h
//  Swiflection
//
//  Created by Leo G Dion on 11/3/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef id (^factory)(NSArray *);


@interface MethodImp : NSObject
+ (factory) closureFromImplementation: (IMP) implementation fromClass:(id) cls withSelector: (SEL) selector;
@end