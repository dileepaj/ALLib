//
//  FuzzySystemTest2.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/21/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "FuzzySystemTest2.h"
#import "ALFuzzySet.h"
#import "ALFuzzyUniverse.h"
#import "ALFuzzyRule.h"
#import "ALFuzzyRuleSet.h"
#import "ALFuzzyEvaluator.h"
#import "ALFuzzyVariable.h"
#import "ALAtomicStatement.h"
#import "ALCompoundStatement.h"

@implementation FuzzySystemTest2

- (void) createSystem {
/*    // create input universe
    universe = [ALFuzzyUniverse new];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 100; ++i) {
        [arr addObject:[NSNumber numberWithInt:i]];
    }
    universe.values = arr;
    
    // create input fuzzy sets
    low = [ALFuzzySet new];
    low.universe = universe;
    [low setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 5) {
            return nf(1.0);
        }
        if (num < 15) {
            return nf(((double)(15 - num)) / 10);
        }
        return nf(0.0);
    }];
    
    verylow = [ALFuzzySet new];
    verylow.universe = universe;
    [verylow setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 5) {
            return nf(1.0);
        }
        if (num < 15) {
            double dd = ((double)(15 - num)) / 10;
            return nf(dd * dd);
        }
        return nf(0.0);
    }];
    
    medium = [ALFuzzySet new];
    medium.universe = universe;
    [medium setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if ((num <= 10) || (num >= 40)) {
            return nf(0.0);
        }
        if (num <= 20) {
            return nf(((double)(num - 10)) / 10);
        }
        return nf(((double)(40 - num)) / 20);
    }];
    
    high = [ALFuzzySet new];
    high.universe = universe;
    [high setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 20) {
            return nf(0.0);
        }
        if (num >= 100) {
            return nf(1.0);
        }
        return nf(((double)(num - 20)) / 80);
    }];
    
    veryhigh = [ALFuzzySet new];
    veryhigh.universe = universe;
    [veryhigh setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 20) {
            return nf(0.0);
        }
        if (num >= 100) {
            return nf(1.0);
        }
        double dd = ((double)(num - 20)) / 80;
        return nf(dd * dd);
    }];
    
    // create second input universe
    universe2 = [ALFuzzyUniverse new];
    arr = [NSMutableArray array];
    for (int i = 0; i < 30; ++i) {
        [arr addObject:[NSNumber numberWithInt:i]];
    }
    universe2.values = arr;
    
    // create fuzzy sets for second universe
    low2 = [ALFuzzySet new];
    low2.universe = universe2;
    [low2 setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 5) {
            return nf(1.0);
        }
        if (num >= 15) {
            return nf(0.0);
        }
        return nf(((double)(15 - num)) / 10);
    }];
    
    verylow2 = [ALFuzzySet new];
    [verylow2 setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 5) {
            return nf(1.0);
        }
        if (num >= 15) {
            return nf(0.0);
        }
        double dd = ((double)(15 - num)) / 10;
        return nf(dd * dd);
    }];
    
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
    decision = [ALFuzzyVariable new];
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
 */
}


- (void)setUp {
    [self createSystem];
}

- (void)tearDown {
    eval = nil;
}

@end
