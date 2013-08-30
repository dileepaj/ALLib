//
//  ALMultiplication.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 7/20/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALMultiplication.h"
#import "ALFuzzySet.h"

@implementation ALMultiplication

// multiply condition with each value in the action set
// approriate for binary decision evaluations
- (ALFuzzySet *)evaluateIf:(NSNumber *)condition withThen:(ALFuzzySet *)action {
    ALFuzzySet *ret = [ALFuzzySet new];
    ret.universe = action.universe;
    ret.possibilities = [NSMutableDictionary dictionary];
    NSEnumerator *ite = [action.possibilities keyEnumerator];
    for (NSNumber *value in ite) {
        [ret.possibilities setObject:[NSNumber numberWithDouble:([condition floatValue] * [[action.possibilities objectForKey:value] floatValue])] forKey:value];
    }
    return ret;
}

@end
