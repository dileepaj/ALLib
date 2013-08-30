//
//  Utils.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/9/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSNumber *)getMaxOutOf:(NSNumber *)num1 andNumber:(NSNumber *)num2 {
    if ([num1 compare:num2] == NSOrderedAscending) {
        return num2;
    }
    return num1;
}

+ (NSNumber *)getMinOutOf:(NSNumber *)num1 andNumber:(NSNumber *)num2 {
    if ([num1 compare:num2] == NSOrderedAscending) {
        return num1;
    }
    return num2;
}

@end
