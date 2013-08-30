//
//  ALExplanation.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 7/20/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALBinaryDecisionEvaluationResult.h"
#import "Defs.h"

@implementation ALBinaryDecisionEvaluationResult

- (id)init {
    self = [super init];
    if (self) {
        _matchingRules = [NSMutableArray array];
        _rulesMatchingDegrees = [NSMutableArray array];
        _totalNegative = zero;
        _totalPositive = zero;
        _finalResult = EvaluationResult_Indeterminate;
    }
    return self;
}

@end
