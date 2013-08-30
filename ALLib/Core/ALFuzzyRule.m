//
//  ALFuzzyRule.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALFuzzyRule.h"
#import "ALZadeh.h"
#import "ALCompoundStatement.h"
#import "ALFuzzySet.h"
#import "ALAtomicStatement.h"
#import "ALMultiplication.h"

@implementation ALFuzzyRule

- (id) init {
    self = [super init];
    if (self) {
        ifThenOperator = [ALMultiplication new];    //[ALZadeh new];
    }
    return self;
}

+ (ALFuzzyRule *)ruleWithCause:(ALCompoundStatement *)cause andResult:(ALAtomicStatement *)result {
    ALFuzzyRule *rule = [ALFuzzyRule new];
    rule.cause = cause;
    rule.result = result;
    return rule;
}

- (void)setIfThenOperator:(id<ALSemantic_IfThen>)op {
    ifThenOperator = op;
}

- (ALFuzzySet *)evaluateForCase:(ALCompoundStatement *)input {
    NSNumber *force = [self.cause getCompositionFollowedByAnd:input];
    ALFuzzySet *res = [ifThenOperator evaluateIf:force withThen:self.result.set];
    return res;
}

@end
