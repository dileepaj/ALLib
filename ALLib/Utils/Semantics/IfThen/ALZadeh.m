//
//  ALZadeh.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/9/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALZadeh.h"
#import "ALFuzzySet.h"
#import "ALFuzzyUniverse.h"

@implementation ALZadeh

- (ALFuzzySet *)evaluateIf:(NSNumber *)condition withThen:(ALFuzzySet *)action {
    ALFuzzySet *ret = [ALFuzzySet new];
    ret.universe = action.universe;
    ret.possibilities = [NSMutableDictionary dictionary];
    NSEnumerator *ite = [action.possibilities keyEnumerator];
    for (NSNumber *value in ite) {
        NSNumber *derivedValue = [Utils getMinOutOf:one andNumber:nf(1 - [condition floatValue] + [[action.possibilities objectForKey:value] floatValue])];
        [ret.possibilities setObject:derivedValue forKey:value];
    }
    return ret;
}

@end
