//
//  ALFuzzyRuleSet.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALFuzzyRuleSet.h"
#import "ALUnion.h"
#import "ALFuzzyRule.h"
#import "ALFuzzySet.h"

@implementation ALFuzzyRuleSet

- (id) init {
    self = [super init];
    if (self) {
        alsoOperator = [ALUnion new];
    }
    return self;
}

+ (ALFuzzyRuleSet *)rulesetWithRules:(NSArray *)rules {
    ALFuzzyRuleSet *ruleset = [ALFuzzyRuleSet new];
    ruleset.rules = [NSMutableArray arrayWithArray:rules];
    return ruleset;
}

- (void)setAlsoOperator:(id<ALSemantic_Also>)op {
    alsoOperator = op;
}

- (ALFuzzySet *)evaluateCase:(ALCompoundStatement *)input {
    NSMutableArray *ruleLevelResults = [NSMutableArray array];
    for (ALFuzzyRule *rule in self.rules) {
        ALFuzzySet *ruleEvaluationResult = [rule evaluateForCase:input];
        [ruleLevelResults addObject:ruleEvaluationResult];
    }
    return [alsoOperator evualuateAlso:ruleLevelResults];
}

- (NSMutableArray *)getIndividualEvaluationResults:(ALCompoundStatement *)input andPutTheRulesIn : (NSMutableArray **) pRules{
    (*pRules) = [NSMutableArray array];
    NSMutableArray *ruleLevelResults = [NSMutableArray array];
    for (ALFuzzyRule *rule in self.rules) {
        ALFuzzySet *ruleEvaluationResult = [rule evaluateForCase:input];
        [ruleLevelResults addObject:ruleEvaluationResult];
        [(*pRules) addObject:rule];
    }
    return ruleLevelResults;
}

@end
