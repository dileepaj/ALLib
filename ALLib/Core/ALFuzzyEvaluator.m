//
//  ALFuzzyEvaluator.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALFuzzyEvaluator.h"
#import "ALFuzzyRule.h"
#import "ALFuzzyRuleSet.h"
#import "ALFuzzySet.h"
#import "ALBinaryDecisionEvaluationResult.h"
#import "Defs.h"

@implementation ALFuzzyEvaluator

- (ALFuzzySet *)evaluateCase:(ALCompoundStatement *)input {
    return [self.ruleSet evaluateCase:input];
}

- (ALBinaryDecisionEvaluationResult *)evaluateBinaryDecisionCase:(ALCompoundStatement *)input {
    NSMutableArray *rules = nil;
    NSMutableArray *individualRuleEvaluationResults = [self.ruleSet getIndividualEvaluationResults:input andPutTheRulesIn:&rules];
    ALBinaryDecisionEvaluationResult *res = [ALBinaryDecisionEvaluationResult new];
    double totalNegative = 0.0f;
    double totalPositive = 0.0f;
    NSUInteger ruleCount = [rules count];
    for (int index = 0; index < ruleCount; ++index) {
        ALFuzzySet *set = [individualRuleEvaluationResults objectAtIndex:index];
        NSNumber *noValue = [set.possibilities objectForKey:zero];
        NSNumber *yesValue = [set.possibilities objectForKey:one];
        if ([noValue floatValue] > 0.0f) {
            totalNegative += [noValue floatValue];
            [res.rulesMatchingDegrees addObject:noValue];
            [res.matchingRules addObject:[rules objectAtIndex:index]];
        } else if ([yesValue floatValue] > 0.0f) {
            totalPositive += [yesValue floatValue];
            [res.rulesMatchingDegrees addObject:yesValue];
            [res.matchingRules addObject:[rules objectAtIndex:index]];
        }
    }
    
    res.totalPositive = nf(totalPositive);
    res.totalNegative = nf(totalNegative);
    
    if (totalPositive > totalNegative) {
        res.finalResult = EvaluationResult_Yes;
    } else if (totalPositive < totalNegative) {
        res.finalResult = EvaluationResult_No;
    } else {
        res.finalResult = EvaluationResult_Indeterminate;
    }
    
    return res;
}

@end
