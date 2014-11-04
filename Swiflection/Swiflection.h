//
//  Swiflection.h
//  Swiflection
//
//  Created by Leo G Dion on 11/3/14.
//  Copyright (c) 2014 BrightDigit, LLC. All rights reserved.
//

#ifndef Swiflection_Swiflection_h
#define Swiflection_Swiflection_h


typedef id (^factory)(void);
static factory closureFromImplementation (IMP implementation);

#endif
