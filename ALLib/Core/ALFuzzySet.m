//
//  ALFuzzySet.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALFuzzySet.h"
#import "ALFuzzyUniverse.h"

@implementation ALFuzzySet

- (void)setPossibilityFunction:(NSNumber *(^)(NSNumber *))func {
    _possibilities = [NSMutableDictionary dictionary];
    for (NSNumber *val in _universe.values) {
        [_possibilities setObject:func(val) forKey:val];
    }
}

@end
