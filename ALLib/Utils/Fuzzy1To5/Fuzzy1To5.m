//
//  Fuzzy1To5.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 7/22/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "Fuzzy1To5.h"
#import "Defs.h"

@implementation Fuzzy1To5Universe

- (id) init {
    self = [super init];
    if (self) {
        self.values = (NSMutableArray *) @[nf(1.0), nf(2.0), nf(3.0), nf(4.0), nf(5.0)];
    }
    return self;
}

@end

@implementation Fuzzy1To5Variable

- (id) init {
    self = [super init];
    if (self) {
        self.universe = [Fuzzy1To5Universe new];
    }
    return self;
}

@end


@implementation Fuzzy1To5VeryLow

- (id) init {
    self = [super init];
    if (self) {
        self.universe = [Fuzzy1To5Universe new];
        self.possibilities = (NSMutableDictionary *) @{nf(1.0) : nf(1.0), nf(2.0) : nf(0.5625), nf(3.0) : nf(0.25), nf(4.0) : nf(0.0625), nf(5.0) : nf(0.0)};
    }
    return self;
}

@end

@implementation Fuzzy1To5Low

- (id) init {
    self = [super init];
    if (self) {
        self.universe = [Fuzzy1To5Universe new];
        self.possibilities = (NSMutableDictionary *) @{nf(1.0) : nf(0.8), nf(2.0) : nf(0.6), nf(3.0) : nf(0.4), nf(4.0) : nf(0.2), nf(5.0) : nf(0.0)};
    }
    return self;
}

@end

@implementation Fuzzy1To5Medium

- (id) init {
    self = [super init];
    if (self) {
        self.universe = [Fuzzy1To5Universe new];
        self.possibilities = (NSMutableDictionary *) @{nf(1.0) : nf(0.1), nf(2.0) : nf(0.55), nf(3.0) : nf(1.0), nf(4.0) : nf(0.55), nf(5.0) : nf(0.1)};
    }
    return self;
}

@end

@implementation Fuzzy1To5High

- (id) init {
    self = [super init];
    if (self) {
        self.universe = [Fuzzy1To5Universe new];
        self.possibilities = (NSMutableDictionary *) @{nf(1.0) : nf(0.0), nf(2.0) : nf(0.2), nf(3.0) : nf(0.4), nf(4.0) : nf(0.6), nf(5.0) : nf(0.8)};
    }
    return self;
}

@end

@implementation Fuzzy1To5VeryHigh

- (id) init {
    self = [super init];
    if (self) {
        self.universe = [Fuzzy1To5Universe new];
        self.possibilities = (NSMutableDictionary *) @{nf(1.0) : nf(0.0), nf(2.0) : nf(0.0625), nf(3.0) : nf(0.25), nf(4.0) : nf(0.5625), nf(5.0) : nf(1.0)};
    }
    return self;
}

@end

@implementation Fuzzy1To5

+ (ALFuzzySet *)fuzzySetWithValue:(NSUInteger)val {
    ALFuzzySet *set = [ALFuzzySet new];
    set.universe = [Fuzzy1To5Universe new];
    [set setPossibilityFunction:^NSNumber *(NSNumber *num) {
        if ([num isEqualToNumber:[NSNumber numberWithInteger:val]]) {
            return one;
        }
        return zero;
    }];
    return set;
}

@end