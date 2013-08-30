//
//  ALSupMin.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/9/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALSupMin.h"
#import "ALFuzzySet.h"

@implementation ALSupMin

- (NSNumber *)getCompositionalInferenceOfSet:(ALFuzzySet *)set1 withSet:(ALFuzzySet *)set2 {
    NSNumber *ret = zero;
    NSEnumerator *ite = [set1.possibilities keyEnumerator];
    for (NSNumber *value in ite) {
        NSNumber *possib1 = [set1.possibilities objectForKey:value];
        NSNumber *possib2 = [set2.possibilities objectForKey:value];
        NSNumber *min = [Utils getMinOutOf:possib1 andNumber:possib2];
        ret = [Utils getMaxOutOf:ret andNumber:min];
    }
    return ret;
}

@end
