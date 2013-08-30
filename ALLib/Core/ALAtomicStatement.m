//
//  ALAtomicStatement.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALAtomicStatement.h"
#import "ALSupMin.h"

@implementation ALAtomicStatement

- (id) init {
    self = [super init];
    if (self) {
        compositionOperator = [ALSupMin new];
    }
    return self;
}

+ (ALAtomicStatement *)stmWithVariable:(ALFuzzyVariable *)var andFuzzySet:(ALFuzzySet *)set {
    ALAtomicStatement *as = [ALAtomicStatement new];
    as.variable = var;
    as.set = set;
    return as;
}

- (void)setCompositionOperator:(id<ALSemantic_CompositionalInference>)op {
    compositionOperator = op;
}

- (NSNumber *)getCompositionWithSet:(ALFuzzySet *)setToCompose {
    return [compositionOperator getCompositionalInferenceOfSet:self.set withSet:setToCompose];
}

@end
