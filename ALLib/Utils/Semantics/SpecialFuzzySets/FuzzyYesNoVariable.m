//
//  FuzzyYesNoVariable.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 7/22/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "FuzzyYesNoVariable.h"
#import "ALFuzzyUniverse.h"
#import "Commons.h"

@implementation FuzzyYesNoVariable

- (id) init {
    self = [super init];
    if (self) {
        ALFuzzyUniverse *universe = [ALFuzzyUniverse new];
        universe.values = (NSMutableArray *) @[one, zero];
        self.universe = universe;
    }
    return self;
}

@end
