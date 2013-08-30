//
//  FuzzySystemTest3.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/23/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "FuzzySystemTest3.h"
#import "ALFuzzySet.h"
#import "ALFuzzyUniverse.h"
#import "ALFuzzyRule.h"
#import "ALFuzzyRuleSet.h"
#import "ALFuzzyEvaluator.h"
#import "ALFuzzyVariable.h"
#import "ALAtomicStatement.h"
#import "ALCompoundStatement.h"

@implementation FuzzySystemTest3

- (void) createSystem {
    // create input universe
    universe = [ALFuzzyUniverse new];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i <= 150; ++i) {
        [arr addObject:[NSNumber numberWithInt:i]];
    }
    universe.values = arr;
    
    // create input fuzzy sets
    low = [ALFuzzySet new];
    low.universe = universe;
    NSMutableArray *values = [NSMutableArray array];
    for (int j = 0; j < 15; ++j) {
        [values addObject:ni(j)];
    }
    [low setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 5) {
            return nf(1.0);
        }
        if (num < 15) {
            return nf(((double)(15 - num)) / 10);
        }
        return nf(0.0);
    } forValues:values];
    
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
    } forValues:values];
    
    medium = [ALFuzzySet new];
    medium.universe = universe;
    values = [NSMutableArray array];
    for (int j = 11; j < 40; ++j) {
        [values addObject:ni(j)];
    }
    [medium setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if ((num <= 10) || (num >= 40)) {
            return nf(0.0);
        }
        if (num <= 20) {
            return nf(((double)(num - 10)) / 10);
        }
        return nf(((double)(40 - num)) / 20);
    } forValues:values];
    
    high = [ALFuzzySet new];
    high.universe = universe;
    values = [NSMutableArray array];
    for (int j = 21; j <= 150; ++j) {
        [values addObject:ni(j)];
    }
    [high setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 20) {
            return nf(0.0);
        }
        if (num >= 100) {
            return nf(1.0);
        }
        return nf(((double)(num - 20)) / 80);
    } forValues:values];
    
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
    } forValues:values];
    
    // create second input universe
    universe2 = [ALFuzzyUniverse new];
    arr = [NSMutableArray array];
    for (int i = 0; i <= 30; ++i) {
        [arr addObject:[NSNumber numberWithInt:i]];
    }
    universe2.values = arr;
    
    // create fuzzy sets for second universe
    low2 = [ALFuzzySet new];
    low2.universe = universe2;
    values = [NSMutableArray array];
    for (int j = 0; j < 15; ++j) {
        [values addObject:ni(j)];
    }
    [low2 setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 5) {
            return nf(1.0);
        }
        if (num >= 15) {
            return nf(0.0);
        }
        return nf(((double)(15 - num)) / 10);
    } forValues:values];
    
    verylow2 = [ALFuzzySet new];
    verylow2.universe = universe2;
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
    } forValues:values];
    
    medium2 = [ALFuzzySet new];
    medium2.universe = universe2;
    values = [NSMutableArray array];
    for (int j = 11; j < 20; ++j) {
        [values addObject:ni(j)];
    }
    [medium2 setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 10) {
            return nf(0.0);
        }
        if (num >= 20) {
            return nf(0.0);
        }
        if (num <= 15) {
            return nf(((double)(num - 10)) / 5);
        }
        return nf(((double)(25 - num)) / 10);
    } forValues:values];
    
    high2 = [ALFuzzySet new];
    high2.universe = universe2;
    values = [NSMutableArray array];
    for (int j = 16; j <= 30; ++j) {
        [values addObject:ni(j)];
    }
    [high2 setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 15) {
            return nf(0.0);
        }
        if (num >= 25) {
            return nf(1.0);
        }
        return nf(((double)(num - 15)) / 10);
    } forValues:values];
    
    veryhigh2 = [ALFuzzySet new];
    veryhigh2.universe = universe2;
    [veryhigh2 setPossibilityFunction:^NSNumber *(NSNumber *val) {
        int num = [val intValue];
        if (num <= 15) {
            return nf(0.0);
        }
        if (num >= 25) {
            return nf(1.0);
        }
        double dd = ((double)(num - 15)) / 10;
        return nf(dd * dd);
    } forValues:values];
    
    // create output universe
    outputUniverse = [ALFuzzyUniverse new];
    outputUniverse.values = [NSArray arrayWithObjects:ni(0), ni(1), nil];
    
    // create output fuzzy sets
    yesSet = [ALFuzzySet new];
    yesSet.universe = outputUniverse;
    yesSet.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(0.0), ni(0), nf(1.0), ni(1), nil];
    
    noSet = [ALFuzzySet new];
    noSet.universe = outputUniverse;
    noSet.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(0), nf(0.0), ni(1), nil];
    
    // create input variables
    p1 = [ALFuzzyVariable new];
    p1.universe = universe;
    
    p2 = [ALFuzzyVariable new];
    p2.universe = universe;
    
    p3 = [ALFuzzyVariable new];
    p3.universe = universe2;
    
    // create output variable
    decision = [ALFuzzyVariable new];
    decision.universe = outputUniverse;
    
    // create evaluator
    eval = [ALFuzzyEvaluator new];
}

- (void) createRules {
	ALAtomicStatement *as1 = nil;
	ALAtomicStatement *as2 = nil;
	ALAtomicStatement *as3 = nil;
	ALCompoundStatement *cs = nil;
	ALAtomicStatement *action = nil;
    
	// create rule set
	ALFuzzyRuleSet *ruleset = [ALFuzzyRuleSet new];
	ruleset.rules = [NSMutableArray array];
	eval.ruleSet = ruleset;
    
	//create rule 1
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule1 = [ALFuzzyRule new];
	rule1.cause = cs;
	rule1.result = action;
	[ruleset.rules addObject:rule1];
    
	//create rule 2
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule2 = [ALFuzzyRule new];
	rule2.cause = cs;
	rule2.result = action;
	[ruleset.rules addObject:rule2];
    
	//create rule 3
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule3 = [ALFuzzyRule new];
	rule3.cause = cs;
	rule3.result = action;
	[ruleset.rules addObject:rule3];
    
	//create rule 4
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule4 = [ALFuzzyRule new];
	rule4.cause = cs;
	rule4.result = action;
	[ruleset.rules addObject:rule4];
    
	//create rule 5
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule5 = [ALFuzzyRule new];
	rule5.cause = cs;
	rule5.result = action;
	[ruleset.rules addObject:rule5];
    
	//create rule 6
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule6 = [ALFuzzyRule new];
	rule6.cause = cs;
	rule6.result = action;
	[ruleset.rules addObject:rule6];
    
	//create rule 7
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule7 = [ALFuzzyRule new];
	rule7.cause = cs;
	rule7.result = action;
	[ruleset.rules addObject:rule7];
    
	//create rule 8
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule8 = [ALFuzzyRule new];
	rule8.cause = cs;
	rule8.result = action;
	[ruleset.rules addObject:rule8];
    
	//create rule 9
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule9 = [ALFuzzyRule new];
	rule9.cause = cs;
	rule9.result = action;
	[ruleset.rules addObject:rule9];
    
	//create rule 10
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule10 = [ALFuzzyRule new];
	rule10.cause = cs;
	rule10.result = action;
	[ruleset.rules addObject:rule10];
    
	//create rule 11
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule11 = [ALFuzzyRule new];
	rule11.cause = cs;
	rule11.result = action;
	[ruleset.rules addObject:rule11];
    
	//create rule 12
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule12 = [ALFuzzyRule new];
	rule12.cause = cs;
	rule12.result = action;
	[ruleset.rules addObject:rule12];
    
	//create rule 13
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule13 = [ALFuzzyRule new];
	rule13.cause = cs;
	rule13.result = action;
	[ruleset.rules addObject:rule13];
    
	//create rule 14
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule14 = [ALFuzzyRule new];
	rule14.cause = cs;
	rule14.result = action;
	[ruleset.rules addObject:rule14];
    
	//create rule 15
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule15 = [ALFuzzyRule new];
	rule15.cause = cs;
	rule15.result = action;
	[ruleset.rules addObject:rule15];
    
	//create rule 16
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule16 = [ALFuzzyRule new];
	rule16.cause = cs;
	rule16.result = action;
	[ruleset.rules addObject:rule16];
    
	//create rule 17
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule17 = [ALFuzzyRule new];
	rule17.cause = cs;
	rule17.result = action;
	[ruleset.rules addObject:rule17];
    
	//create rule 18
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule18 = [ALFuzzyRule new];
	rule18.cause = cs;
	rule18.result = action;
	[ruleset.rules addObject:rule18];
    
	//create rule 19
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule19 = [ALFuzzyRule new];
	rule19.cause = cs;
	rule19.result = action;
	[ruleset.rules addObject:rule19];
    
	//create rule 20
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule20 = [ALFuzzyRule new];
	rule20.cause = cs;
	rule20.result = action;
	[ruleset.rules addObject:rule20];
    
	//create rule 21
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule21 = [ALFuzzyRule new];
	rule21.cause = cs;
	rule21.result = action;
	[ruleset.rules addObject:rule21];
    
	//create rule 22
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule22 = [ALFuzzyRule new];
	rule22.cause = cs;
	rule22.result = action;
	[ruleset.rules addObject:rule22];
    
	//create rule 23
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule23 = [ALFuzzyRule new];
	rule23.cause = cs;
	rule23.result = action;
	[ruleset.rules addObject:rule23];
    
	//create rule 24
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule24 = [ALFuzzyRule new];
	rule24.cause = cs;
	rule24.result = action;
	[ruleset.rules addObject:rule24];
    
	//create rule 25
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule25 = [ALFuzzyRule new];
	rule25.cause = cs;
	rule25.result = action;
	[ruleset.rules addObject:rule25];
    
	//create rule 26
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule26 = [ALFuzzyRule new];
	rule26.cause = cs;
	rule26.result = action;
	[ruleset.rules addObject:rule26];
    
	//create rule 27
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule27 = [ALFuzzyRule new];
	rule27.cause = cs;
	rule27.result = action;
	[ruleset.rules addObject:rule27];
    
	//create rule 28
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule28 = [ALFuzzyRule new];
	rule28.cause = cs;
	rule28.result = action;
	[ruleset.rules addObject:rule28];
    
	//create rule 29
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule29 = [ALFuzzyRule new];
	rule29.cause = cs;
	rule29.result = action;
	[ruleset.rules addObject:rule29];
    
	//create rule 30
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule30 = [ALFuzzyRule new];
	rule30.cause = cs;
	rule30.result = action;
	[ruleset.rules addObject:rule30];
    
	//create rule 31
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule31 = [ALFuzzyRule new];
	rule31.cause = cs;
	rule31.result = action;
	[ruleset.rules addObject:rule31];
    
	//create rule 32
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule32 = [ALFuzzyRule new];
	rule32.cause = cs;
	rule32.result = action;
	[ruleset.rules addObject:rule32];
    
	//create rule 33
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule33 = [ALFuzzyRule new];
	rule33.cause = cs;
	rule33.result = action;
	[ruleset.rules addObject:rule33];
    
	//create rule 34
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule34 = [ALFuzzyRule new];
	rule34.cause = cs;
	rule34.result = action;
	[ruleset.rules addObject:rule34];
    
	//create rule 35
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule35 = [ALFuzzyRule new];
	rule35.cause = cs;
	rule35.result = action;
	[ruleset.rules addObject:rule35];
    
	//create rule 36
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule36 = [ALFuzzyRule new];
	rule36.cause = cs;
	rule36.result = action;
	[ruleset.rules addObject:rule36];
    
	//create rule 37
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule37 = [ALFuzzyRule new];
	rule37.cause = cs;
	rule37.result = action;
	[ruleset.rules addObject:rule37];
    
	//create rule 38
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule38 = [ALFuzzyRule new];
	rule38.cause = cs;
	rule38.result = action;
	[ruleset.rules addObject:rule38];
    
	//create rule 39
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule39 = [ALFuzzyRule new];
	rule39.cause = cs;
	rule39.result = action;
	[ruleset.rules addObject:rule39];
    
	//create rule 40
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule40 = [ALFuzzyRule new];
	rule40.cause = cs;
	rule40.result = action;
	[ruleset.rules addObject:rule40];
    
	//create rule 41
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule41 = [ALFuzzyRule new];
	rule41.cause = cs;
	rule41.result = action;
	[ruleset.rules addObject:rule41];
    
	//create rule 42
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = high2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule42 = [ALFuzzyRule new];
	rule42.cause = cs;
	rule42.result = action;
	[ruleset.rules addObject:rule42];
    
	//create rule 43
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule43 = [ALFuzzyRule new];
	rule43.cause = cs;
	rule43.result = action;
	[ruleset.rules addObject:rule43];
    
	//create rule 44
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule44 = [ALFuzzyRule new];
	rule44.cause = cs;
	rule44.result = action;
	[ruleset.rules addObject:rule44];
    
	//create rule 45
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule45 = [ALFuzzyRule new];
	rule45.cause = cs;
	rule45.result = action;
	[ruleset.rules addObject:rule45];
    
	//create rule 46
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule46 = [ALFuzzyRule new];
	rule46.cause = cs;
	rule46.result = action;
	[ruleset.rules addObject:rule46];
    
	//create rule 47
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule47 = [ALFuzzyRule new];
	rule47.cause = cs;
	rule47.result = action;
	[ruleset.rules addObject:rule47];
    
	//create rule 48
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule48 = [ALFuzzyRule new];
	rule48.cause = cs;
	rule48.result = action;
	[ruleset.rules addObject:rule48];
    
	//create rule 49
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule49 = [ALFuzzyRule new];
	rule49.cause = cs;
	rule49.result = action;
	[ruleset.rules addObject:rule49];
    
	//create rule 50
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule50 = [ALFuzzyRule new];
	rule50.cause = cs;
	rule50.result = action;
	[ruleset.rules addObject:rule50];
    
	//create rule 51
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule51 = [ALFuzzyRule new];
	rule51.cause = cs;
	rule51.result = action;
	[ruleset.rules addObject:rule51];
    
	//create rule 52
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule52 = [ALFuzzyRule new];
	rule52.cause = cs;
	rule52.result = action;
	[ruleset.rules addObject:rule52];
    
	//create rule 53
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule53 = [ALFuzzyRule new];
	rule53.cause = cs;
	rule53.result = action;
	[ruleset.rules addObject:rule53];
    
	//create rule 54
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule54 = [ALFuzzyRule new];
	rule54.cause = cs;
	rule54.result = action;
	[ruleset.rules addObject:rule54];
    
	//create rule 55
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule55 = [ALFuzzyRule new];
	rule55.cause = cs;
	rule55.result = action;
	[ruleset.rules addObject:rule55];
    
	//create rule 56
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule56 = [ALFuzzyRule new];
	rule56.cause = cs;
	rule56.result = action;
	[ruleset.rules addObject:rule56];
    
	//create rule 57
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule57 = [ALFuzzyRule new];
	rule57.cause = cs;
	rule57.result = action;
	[ruleset.rules addObject:rule57];
    
	//create rule 58
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule58 = [ALFuzzyRule new];
	rule58.cause = cs;
	rule58.result = action;
	[ruleset.rules addObject:rule58];
    
	//create rule 59
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule59 = [ALFuzzyRule new];
	rule59.cause = cs;
	rule59.result = action;
	[ruleset.rules addObject:rule59];
    
	//create rule 60
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule60 = [ALFuzzyRule new];
	rule60.cause = cs;
	rule60.result = action;
	[ruleset.rules addObject:rule60];
    
	//create rule 61
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = low2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule61 = [ALFuzzyRule new];
	rule61.cause = cs;
	rule61.result = action;
	[ruleset.rules addObject:rule61];
    
	//create rule 62
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule62 = [ALFuzzyRule new];
	rule62.cause = cs;
	rule62.result = action;
	[ruleset.rules addObject:rule62];
    
	//create rule 63
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule63 = [ALFuzzyRule new];
	rule63.cause = cs;
	rule63.result = action;
	[ruleset.rules addObject:rule63];
    
	//create rule 64
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule64 = [ALFuzzyRule new];
	rule64.cause = cs;
	rule64.result = action;
	[ruleset.rules addObject:rule64];
    
	//create rule 65
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule65 = [ALFuzzyRule new];
	rule65.cause = cs;
	rule65.result = action;
	[ruleset.rules addObject:rule65];
    
	//create rule 66
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule66 = [ALFuzzyRule new];
	rule66.cause = cs;
	rule66.result = action;
	[ruleset.rules addObject:rule66];
    
	//create rule 67
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule67 = [ALFuzzyRule new];
	rule67.cause = cs;
	rule67.result = action;
	[ruleset.rules addObject:rule67];
    
	//create rule 68
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule68 = [ALFuzzyRule new];
	rule68.cause = cs;
	rule68.result = action;
	[ruleset.rules addObject:rule68];
    
	//create rule 69
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule69 = [ALFuzzyRule new];
	rule69.cause = cs;
	rule69.result = action;
	[ruleset.rules addObject:rule69];
    
	//create rule 70
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule70 = [ALFuzzyRule new];
	rule70.cause = cs;
	rule70.result = action;
	[ruleset.rules addObject:rule70];
    
	//create rule 71
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule71 = [ALFuzzyRule new];
	rule71.cause = cs;
	rule71.result = action;
	[ruleset.rules addObject:rule71];
    
	//create rule 72
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule72 = [ALFuzzyRule new];
	rule72.cause = cs;
	rule72.result = action;
	[ruleset.rules addObject:rule72];
    
	//create rule 73
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule73 = [ALFuzzyRule new];
	rule73.cause = cs;
	rule73.result = action;
	[ruleset.rules addObject:rule73];
    
	//create rule 74
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule74 = [ALFuzzyRule new];
	rule74.cause = cs;
	rule74.result = action;
	[ruleset.rules addObject:rule74];
    
	//create rule 75
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule75 = [ALFuzzyRule new];
	rule75.cause = cs;
	rule75.result = action;
	[ruleset.rules addObject:rule75];
    
	//create rule 76
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule76 = [ALFuzzyRule new];
	rule76.cause = cs;
	rule76.result = action;
	[ruleset.rules addObject:rule76];
    
	//create rule 77
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule77 = [ALFuzzyRule new];
	rule77.cause = cs;
	rule77.result = action;
	[ruleset.rules addObject:rule77];
    
	//create rule 78
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule78 = [ALFuzzyRule new];
	rule78.cause = cs;
	rule78.result = action;
	[ruleset.rules addObject:rule78];
    
	//create rule 79
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule79 = [ALFuzzyRule new];
	rule79.cause = cs;
	rule79.result = action;
	[ruleset.rules addObject:rule79];
    
	//create rule 80
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule80 = [ALFuzzyRule new];
	rule80.cause = cs;
	rule80.result = action;
	[ruleset.rules addObject:rule80];
    
	//create rule 81
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule81 = [ALFuzzyRule new];
	rule81.cause = cs;
	rule81.result = action;
	[ruleset.rules addObject:rule81];
    
	//create rule 82
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule82 = [ALFuzzyRule new];
	rule82.cause = cs;
	rule82.result = action;
	[ruleset.rules addObject:rule82];
    
	//create rule 83
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule83 = [ALFuzzyRule new];
	rule83.cause = cs;
	rule83.result = action;
	[ruleset.rules addObject:rule83];
    
	//create rule 84
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule84 = [ALFuzzyRule new];
	rule84.cause = cs;
	rule84.result = action;
	[ruleset.rules addObject:rule84];
    
	//create rule 85
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule85 = [ALFuzzyRule new];
	rule85.cause = cs;
	rule85.result = action;
	[ruleset.rules addObject:rule85];
    
	//create rule 86
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule86 = [ALFuzzyRule new];
	rule86.cause = cs;
	rule86.result = action;
	[ruleset.rules addObject:rule86];
    
	//create rule 87
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule87 = [ALFuzzyRule new];
	rule87.cause = cs;
	rule87.result = action;
	[ruleset.rules addObject:rule87];
    
	//create rule 88
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule88 = [ALFuzzyRule new];
	rule88.cause = cs;
	rule88.result = action;
	[ruleset.rules addObject:rule88];
    
	//create rule 89
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule89 = [ALFuzzyRule new];
	rule89.cause = cs;
	rule89.result = action;
	[ruleset.rules addObject:rule89];
    
	//create rule 90
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule90 = [ALFuzzyRule new];
	rule90.cause = cs;
	rule90.result = action;
	[ruleset.rules addObject:rule90];
    
	//create rule 91
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule91 = [ALFuzzyRule new];
	rule91.cause = cs;
	rule91.result = action;
	[ruleset.rules addObject:rule91];
    
	//create rule 92
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule92 = [ALFuzzyRule new];
	rule92.cause = cs;
	rule92.result = action;
	[ruleset.rules addObject:rule92];
    
	//create rule 93
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule93 = [ALFuzzyRule new];
	rule93.cause = cs;
	rule93.result = action;
	[ruleset.rules addObject:rule93];
    
	//create rule 94
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule94 = [ALFuzzyRule new];
	rule94.cause = cs;
	rule94.result = action;
	[ruleset.rules addObject:rule94];
    
	//create rule 95
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule95 = [ALFuzzyRule new];
	rule95.cause = cs;
	rule95.result = action;
	[ruleset.rules addObject:rule95];
    
	//create rule 96
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = veryhigh;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = veryhigh;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = verylow2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = noSet;
    
	ALFuzzyRule *rule96 = [ALFuzzyRule new];
	rule96.cause = cs;
	rule96.result = action;
	[ruleset.rules addObject:rule96];
    
	//create rule 97
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule97 = [ALFuzzyRule new];
	rule97.cause = cs;
	rule97.result = action;
	[ruleset.rules addObject:rule97];
    
	//create rule 98
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule98 = [ALFuzzyRule new];
	rule98.cause = cs;
	rule98.result = action;
	[ruleset.rules addObject:rule98];
    
	//create rule 99
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule99 = [ALFuzzyRule new];
	rule99.cause = cs;
	rule99.result = action;
	[ruleset.rules addObject:rule99];
    
	//create rule 100
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule100 = [ALFuzzyRule new];
	rule100.cause = cs;
	rule100.result = action;
	[ruleset.rules addObject:rule100];
    
	//create rule 101
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = veryhigh2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule101 = [ALFuzzyRule new];
	rule101.cause = cs;
	rule101.result = action;
	[ruleset.rules addObject:rule101];
    
	//create rule 102
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule102 = [ALFuzzyRule new];
	rule102.cause = cs;
	rule102.result = action;
	[ruleset.rules addObject:rule102];
    
	//create rule 103
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule103 = [ALFuzzyRule new];
	rule103.cause = cs;
	rule103.result = action;
	[ruleset.rules addObject:rule103];
    
	//create rule 104
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule104 = [ALFuzzyRule new];
	rule104.cause = cs;
	rule104.result = action;
	[ruleset.rules addObject:rule104];
    
	//create rule 105
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule105 = [ALFuzzyRule new];
	rule105.cause = cs;
	rule105.result = action;
	[ruleset.rules addObject:rule105];
    
	//create rule 106
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = high;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule106 = [ALFuzzyRule new];
	rule106.cause = cs;
	rule106.result = action;
	[ruleset.rules addObject:rule106];
    
	//create rule 107
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = medium;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule107 = [ALFuzzyRule new];
	rule107.cause = cs;
	rule107.result = action;
	[ruleset.rules addObject:rule107];
    
	//create rule 108
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule108 = [ALFuzzyRule new];
	rule108.cause = cs;
	rule108.result = action;
	[ruleset.rules addObject:rule108];
    
	//create rule 109
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule109 = [ALFuzzyRule new];
	rule109.cause = cs;
	rule109.result = action;
	[ruleset.rules addObject:rule109];
    
	//create rule 110
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule110 = [ALFuzzyRule new];
	rule110.cause = cs;
	rule110.result = action;
	[ruleset.rules addObject:rule110];
    
	//create rule 111
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = high;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule111 = [ALFuzzyRule new];
	rule111.cause = cs;
	rule111.result = action;
	[ruleset.rules addObject:rule111];
    
	//create rule 112
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule112 = [ALFuzzyRule new];
	rule112.cause = cs;
	rule112.result = action;
	[ruleset.rules addObject:rule112];
    
	//create rule 113
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = medium;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule113 = [ALFuzzyRule new];
	rule113.cause = cs;
	rule113.result = action;
	[ruleset.rules addObject:rule113];
    
	//create rule 114
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule114 = [ALFuzzyRule new];
	rule114.cause = cs;
	rule114.result = action;
	[ruleset.rules addObject:rule114];
    
	//create rule 115
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = low;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule115 = [ALFuzzyRule new];
	rule115.cause = cs;
	rule115.result = action;
	[ruleset.rules addObject:rule115];
    
	//create rule 116
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = low;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule116 = [ALFuzzyRule new];
	rule116.cause = cs;
	rule116.result = action;
	[ruleset.rules addObject:rule116];
    
	//create rule 117
	as1 = [ALAtomicStatement new];
	as1.variable = p1;
	as1.set = verylow;
    
	as2 = [ALAtomicStatement new];
	as2.variable = p2;
	as2.set = verylow;
    
	as3 = [ALAtomicStatement new];
	as3.variable = p3;
	as3.set = medium2;
    
	cs = [ALCompoundStatement new];
	cs.statements = [NSArray arrayWithObjects:as1, as2, as3, nil];
    
	action = [ALAtomicStatement new];
	action.variable = decision;
	action.set = yesSet;
    
	ALFuzzyRule *rule117 = [ALFuzzyRule new];
	rule117.cause = cs;
	rule117.result = action;
	[ruleset.rules addObject:rule117];
}

- (void)setUp {
    [self createSystem];
    [self createRules];
}

- (void)tearDown {
    eval = nil;
}

- (void) testCase1 {
    // p1 = 10    p2 = 65   p3 = 20
    ALFuzzySet *s1 = [ALFuzzySet new];
    s1.universe = universe;
    s1.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(40), nil];
    ALAtomicStatement *st1 = [ALAtomicStatement new];
    st1.variable = p1;
    st1.set = s1;
    
    ALFuzzySet *s2 = [ALFuzzySet new];
    s2.universe = universe;
    s2.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(10), nil];
    ALAtomicStatement *st2 = [ALAtomicStatement new];
    st2.variable = p2;
    st2.set = s2;
    
    ALFuzzySet *s3 = [ALFuzzySet new];
    s3.universe = universe2;
    s3.possibilities = [NSDictionary dictionaryWithObjectsAndKeys:nf(1.0), ni(30), nil];
    ALAtomicStatement *st3 = [ALAtomicStatement new];
    st3.variable = p3;
    st3.set = s3;
    
    ALCompoundStatement *cs = [ALCompoundStatement new];
    cs.statements = [NSArray arrayWithObjects:st1, st2, st3, nil];
    
    ALFuzzySet *res = [eval evaluateCase:cs];
    
    NSNumber *yesval = [res getPossibilityForValue:ni(1)];
    NSNumber *noval = [res getPossibilityForValue:ni(0)];
    
    NSLog(@"Yes=%f  No=%f", [yesval floatValue], [noval floatValue]);
    
    STAssertTrue(YES, @"");
}

@end
