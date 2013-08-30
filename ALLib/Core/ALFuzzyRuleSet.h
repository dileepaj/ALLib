//
//  ALFuzzyRuleSet.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALSemantic_Also.h"

@class ALFuzzySet;
@class ALCompoundStatement;

@interface ALFuzzyRuleSet : NSObject {
    id<ALSemantic_Also> alsoOperator;
}

@property NSMutableArray *rules;    // array of ALFuzzyRule's

+ (ALFuzzyRuleSet *) rulesetWithRules : (NSArray *) rules;

- (void) setAlsoOperator : (id<ALSemantic_Also>) op;
- (ALFuzzySet *) evaluateCase : (ALCompoundStatement *) input;
- (NSMutableArray *) getIndividualEvaluationResults : (ALCompoundStatement *) input andPutTheRulesIn : (NSMutableArray **) pRules;

@end
