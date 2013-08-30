//
//  ALUnion.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/9/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALUnion.h"
#import "ALFuzzySet.h"
#import "ALFuzzyUniverse.h"

@implementation ALUnion

- (ALFuzzySet *)evualuateAlso:(NSArray *)sets {
    NSUInteger setCount = [sets count];
    if (setCount == 0) {
        return nil;
    }
    
    ALFuzzySet *firstSet = [sets objectAtIndex:0];
    ALFuzzySet *ret = [ALFuzzySet new];
    ret.possibilities = [NSDictionary dictionary];
    ret.universe = firstSet.universe;
    
    NSUInteger setSize = [firstSet.universe.values count];
    for (int index = 0; index < setSize; ++index) {
        NSNumber *max = zero;
        for (int setIndex = 0; setIndex < setCount; ++setIndex) {
            ALFuzzySet *set = [sets objectAtIndex:setIndex];
            max = [Utils getMaxOutOf:max andNumber:[set.possibilities objectForKey:[set.universe.values objectAtIndex:index]]];
        }
        if ([max compare:zero] == NSOrderedDescending) {
            [ret.possibilities setObject:max forKey:[ret.universe.values objectAtIndex:index]];
        }
    }
    
    return ret;
}

@end
