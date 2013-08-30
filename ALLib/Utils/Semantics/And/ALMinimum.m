//
//  ALMinimum.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/9/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALMinimum.h"

@implementation ALMinimum

- (NSNumber *)getAnd:(NSArray *)values {
    NSNumber *ret = one;
    for (NSNumber *value in values) {
        ret = [Utils getMinOutOf:ret andNumber:value];
    }
    return ret;
}

@end
