//
//  ALFuzzySetYes.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 7/20/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "FuzzyYesSet.h"
#import "Defs.h"

@implementation FuzzyYesSet

- (id) init {
    self = [super init];
    if (self) {
        self.possibilities = [NSMutableDictionary dictionary];
        [self.possibilities setObject:one forKey:one];
        [self.possibilities setObject:zero forKey:zero];
    }
    return self;
}

@end
