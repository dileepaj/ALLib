//
//  FuzzySystemTest1.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/19/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "FuzzySystemTest1.h"
#import "ALFuzzySet.h"
#import "ALFuzzyUniverse.h"
#import "ALFuzzyRule.h"
#import "ALFuzzyRuleSet.h"
#import "ALFuzzyEvaluator.h"
#import "ALFuzzyVariable.h"
#import "ALAtomicStatement.h"
#import "ALCompoundStatement.h"

@implementation FuzzySystemTest1

- (void) createSystem {
    // create input universe
    universe = [ALFuzzyUniverse new];
    universe.values = [NSArray arrayWithObjects:zero ,ni(1), ni(2), ni(3), ni(4), ni(5), nil];
   
    // create input fuzzy sets
    ALFuzzySet *low = [ALFuzzySet new];
    low.universe = universe;
    low.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(1), nf(0.67), ni(2), nf(0.33), ni(3), nil];
    
    ALFuzzySet *verylow = [ALFuzzySet new];
    verylow.universe = universe;
    verylow.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(1), nf(0.45), ni(2), nf(0.1), ni(3), nil];
    
    ALFuzzySet *medium = [ALFuzzySet new];
    medium.universe = universe;
    medium.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(0.5), ni(2), nf(1.0), ni(3), nf(0.5), ni(4), nil];
    
    ALFuzzySet *high = [ALFuzzySet new];
    high.universe = universe;
    high.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(0.33), ni(3), nf(0.67), ni(4), nf(1.0), ni(5), nil];
    
    ALFuzzySet *veryhigh = [ALFuzzySet new];
    veryhigh.universe = universe;
    veryhigh.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(0.1), ni(3), nf(0.45), ni(4), nf(1.0), ni(5), nil];
    
    // create output universe
    outputUniverse = [ALFuzzyUniverse new];
    outputUniverse.values = [NSArray arrayWithObjects:ni(0), ni(1), nil];
    
    // create output fuzzy sets
    ALFuzzySet *yesSet = [ALFuzzySet new];
    yesSet.universe = outputUniverse;
    yesSet.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(0.0), ni(0), nf(1.0), ni(1), nil];
    
    ALFuzzySet *noSet = [ALFuzzySet new];
    noSet.universe = outputUniverse;
    noSet.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(0), nf(0.0), ni(1), nil];
    
    // create input variables
    p1 = [ALFuzzyVariable new];
    p1.universe = universe;
    
    p2 = [ALFuzzyVariable new];
    p2.universe = universe;
    
    p3 = [ALFuzzyVariable new];
    p3.universe = universe;
    
    // create output variable
    ALFuzzyVariable *decision = [ALFuzzyVariable new];
    decision.universe = outputUniverse;
    
    // create rule 1
    // IF {(p1 is verylow) AND (p2 is medium) AND (p3 is low)} THEN (decision is NO)
    ALAtomicStatement *as1 = [ALAtomicStatement new];
    as1.variable = p1;
    as1.set = verylow;
    
    ALAtomicStatement *as2 = [ALAtomicStatement new];
    as2.variable = p2;
    as2.set = medium;
    
    ALAtomicStatement *as3 = [ALAtomicStatement new];
    as3.variable = p3;
    as3.set = low;
    
    ALCompoundStatement *cs = [ALCompoundStatement new];
    cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
    ALAtomicStatement *action = [ALAtomicStatement new];
    action.variable = decision;
    action.set = noSet;
    
    ALFuzzyRule *rule1 = [ALFuzzyRule new];
    rule1.cause = cs;
    rule1.result = action;
    
    // create rule 2
    // IF {(p1 is low) AND (p2 is medium) AND (p3 is veryhigh)} THEN (decision is YES)
    as1 = [ALAtomicStatement new];
    as1.variable = p1;
    as1.set = low;
    
    as2 = [ALAtomicStatement new];
    as2.variable = p2;
    as2.set = medium;
    
    as3 = [ALAtomicStatement new];
    as3.variable = p3;
    as3.set = veryhigh;
    
    cs = [ALCompoundStatement new];
    cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
    action = [ALAtomicStatement new];
    action.variable = decision;
    action.set = yesSet;
    
    ALFuzzyRule *rule2 = [ALFuzzyRule new];
    rule2.cause = cs;
    rule2.result = action;
    
    // create rule 3
    // IF {(p1 is high) AND (p2 is medium) AND (p3 is low)} THEN (decision is NO)
    as1 = [ALAtomicStatement new];
    as1.variable = p1;
    as1.set = high;
    
    as2 = [ALAtomicStatement new];
    as2.variable = p2;
    as2.set = medium;
    
    as3 = [ALAtomicStatement new];
    as3.variable = p3;
    as3.set = low;
    
    cs = [ALCompoundStatement new];
    cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
    action = [ALAtomicStatement new];
    action.variable = decision;
    action.set = noSet;
    
    ALFuzzyRule *rule3 = [ALFuzzyRule new];
    rule3.cause = cs;
    rule3.result = action;
    
    // create rule set and evaluator
    ALFuzzyRuleSet *ruleset = [ALFuzzyRuleSet new];
    ruleset.rules = [NSArray arrayWithObjects:rule1, rule2, rule3, nil];
    eval = [ALFuzzyEvaluator new];
    eval.ruleSet = ruleset;
}

- (void)setUp {
    [self createSystem];
}

- (void)tearDown {
    eval = nil;
}

/*- (void) testCase1 {
    // p1 = 2    p2 = 3   p3 = 1
    ALFuzzySet *s1 = [ALFuzzySet new];
    s1.universe = universe;
    s1.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(2), nil];
    ALAtomicStatement *st1 = [ALAtomicStatement new];
    st1.variable = p1;
    st1.set = s1;
    
    ALFuzzySet *s2 = [ALFuzzySet new];
    s2.universe = universe;
    s2.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(3), nil];
    ALAtomicStatement *st2 = [ALAtomicStatement new];
    st2.variable = p2;
    st2.set = s2;
    
    ALFuzzySet *s3 = [ALFuzzySet new];
    s3.universe = universe;
    s3.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(1), nil];
    ALAtomicStatement *st3 = [ALAtomicStatement new];
    st3.variable = p3;
    st3.set = s3;
    
    ALCompoundStatement *cs = [ALCompoundStatement new];
    cs.statements = [NSArray arrayWithObjects:st1, st2, st3, nil];
    
    ALFuzzySet *res = [eval evaluateCase:cs];
    
    NSNumber *yesval = [res getPossibilityForValue:ni(1)];
    NSNumber *noval = [res getPossibilityForValue:ni(0)];
    
    STAssertTrue(YES, @"");
}

- (void) testCase2 {
    // p1 = 2    p2 = 3   p3 = 4
    ALFuzzySet *s1 = [ALFuzzySet new];
    s1.universe = universe;
    s1.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(2), nil];
    ALAtomicStatement *st1 = [ALAtomicStatement new];
    st1.variable = p1;
    st1.set = s1;
    
    ALFuzzySet *s2 = [ALFuzzySet new];
    s2.universe = universe;
    s2.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(3), nil];
    ALAtomicStatement *st2 = [ALAtomicStatement new];
    st2.variable = p2;
    st2.set = s2;
    
    ALFuzzySet *s3 = [ALFuzzySet new];
    s3.universe = universe;
    s3.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(4), nil];
    ALAtomicStatement *st3 = [ALAtomicStatement new];
    st3.variable = p3;
    st3.set = s3;
    
    ALCompoundStatement *cs = [ALCompoundStatement new];
    cs.statements = [NSArray arrayWithObjects:st1, st2, st3, nil];
    
    ALFuzzySet *res = [eval evaluateCase:cs];
    
    NSNumber *yesval = [res getPossibilityForValue:ni(1)];
    NSNumber *noval = [res getPossibilityForValue:ni(0)];
    
    STAssertTrue(YES, @"");
}

- (void) testCase3 {
    // p1 = 3    p2 = 3   p3 = 3
    ALFuzzySet *s1 = [ALFuzzySet new];
    s1.universe = universe;
    s1.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(3), nil];
    ALAtomicStatement *st1 = [ALAtomicStatement new];
    st1.variable = p1;
    st1.set = s1;
    
    ALFuzzySet *s2 = [ALFuzzySet new];
    s2.universe = universe;
    s2.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(3), nil];
    ALAtomicStatement *st2 = [ALAtomicStatement new];
    st2.variable = p2;
    st2.set = s2;
    
    ALFuzzySet *s3 = [ALFuzzySet new];
    s3.universe = universe;
    s3.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(3), nil];
    ALAtomicStatement *st3 = [ALAtomicStatement new];
    st3.variable = p3;
    st3.set = s3;
    
    ALCompoundStatement *cs = [ALCompoundStatement new];
    cs.statements = [NSArray arrayWithObjects:st1, st2, st3, nil];
    
    ALFuzzySet *res = [eval evaluateCase:cs];
    
    NSNumber *yesval = [res getPossibilityForValue:ni(1)];
    NSNumber *noval = [res getPossibilityForValue:ni(0)];
    
    STAssertTrue(YES, @"");
}

- (void) testCase4 {
    // p1 = 5    p2 = 4   p3 = 1
    ALFuzzySet *s1 = [ALFuzzySet new];
    s1.universe = universe;
    s1.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(5), nil];
    ALAtomicStatement *st1 = [ALAtomicStatement new];
    st1.variable = p1;
    st1.set = s1;
    
    ALFuzzySet *s2 = [ALFuzzySet new];
    s2.universe = universe;
    s2.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(4), nil];
    ALAtomicStatement *st2 = [ALAtomicStatement new];
    st2.variable = p2;
    st2.set = s2;
    
    ALFuzzySet *s3 = [ALFuzzySet new];
    s3.universe = universe;
    s3.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(1), nil];
    ALAtomicStatement *st3 = [ALAtomicStatement new];
    st3.variable = p3;
    st3.set = s3;
    
    ALCompoundStatement *cs = [ALCompoundStatement new];
    cs.statements = [NSArray arrayWithObjects:st1, st2, st3, nil];
    
    ALFuzzySet *res = [eval evaluateCase:cs];
    
    NSNumber *yesval = [res getPossibilityForValue:ni(1)];
    NSNumber *noval = [res getPossibilityForValue:ni(0)];
    
    STAssertTrue(YES, @"");
}*/

@end
