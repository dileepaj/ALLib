//
//  ALFuzzySetNo.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 7/20/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "FuzzyNoSet.h"
#import "Defs.h"

@implementation FuzzyNoSet

- (id) init {
    self = [super init];
    if (self) {
        self.possibilities = [NSMutableDictionary dictionary];
        [self.possibilities setObject:one forKey:zero];
        [self.possibilities setObject:zero forKey:one];
    }
    return self;
}

@end
