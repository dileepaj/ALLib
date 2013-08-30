//
//  ALFuzzyEvaluator.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALFuzzyRuleSet;
@class ALFuzzySet;
@class ALCompoundStatement;
@class ALBinaryDecisionEvaluationResult;

@interface ALFuzzyEvaluator : NSObject

@property ALFuzzyRuleSet *ruleSet;

- (ALFuzzySet *) evaluateCase : (ALCompoundStatement *) input;
- (ALBinaryDecisionEvaluationResult *) evaluateBinaryDecisionCase : (ALCompoundStatement *) input;

@end
