//
//  ALLibTests.m
//  ALLibTests
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALLibTests.h"
#import "ALIncludes.h"
#import "Fuzzy1To5.h"
#import "FuzzyYesNo.h"

@implementation ALLibTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void) test1To5Test1 {
    // fuzzy variables
    Fuzzy1To5Variable *var1 = [Fuzzy1To5Variable new];
    Fuzzy1To5Variable *var2 = [Fuzzy1To5Variable new];
    Fuzzy1To5Variable *var3 = [Fuzzy1To5Variable new];
    
    // input fuzzy sets
    Fuzzy1To5VeryLow *verylow = [Fuzzy1To5VeryLow new];
    Fuzzy1To5Low *low = [Fuzzy1To5Low new];
    Fuzzy1To5Medium *medium = [Fuzzy1To5Medium new];
    Fuzzy1To5High *high = [Fuzzy1To5High new];
    Fuzzy1To5VeryHigh *veryhigh = [Fuzzy1To5VeryHigh new];
    
    // output fuzzy sets
    FuzzyYesSet *yes = [FuzzyYesSet new];
    FuzzyNoSet *no = [FuzzyNoSet new];
    
    ALFuzzyRuleTemplate *template = [ALFuzzyRuleTemplate templateWithInputVariables:@[var1, var2, var3] andOutputVariabe:[FuzzyYesNoVariable new]];
    ALFuzzyRule *rule1 = [template ruleWithInputValues:@[verylow, medium, high] andResult:yes];
    ALFuzzyRule *rule2 = [template ruleWithInputValues:@[high, low, low] andResult:no];
    ALFuzzyRule *rule3 = [template ruleWithInputValues:@[veryhigh, medium, medium] andResult:yes];
    ALFuzzyRule *rule4 = [template ruleWithInputValues:@[medium, low, verylow] andResult:no];
    
    ALFuzzyEvaluator *eval = [ALFuzzyEvaluator new];
    eval.ruleSet = [ALFuzzyRuleSet rulesetWithRules:@[rule1, rule2, rule3, rule4]];
    ALCompoundStatement *scenario = [template scenarioWithValues:@[[Fuzzy1To5 fuzzySetWithValue:2], [Fuzzy1To5 fuzzySetWithValue:3], [Fuzzy1To5 fuzzySetWithValue:4]]];
    ALBinaryDecisionEvaluationResult *res = [eval evaluateBinaryDecisionCase:scenario];
    STAssertTrue(YES, @"");
}

@end
