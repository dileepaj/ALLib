//
//  ALFuzzyRuleTemplate.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 7/22/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALFuzzyRule;
@class ALFuzzyVariable;
@class ALFuzzySet;
@class ALCompoundStatement;

@interface ALFuzzyRuleTemplate : NSObject

@property NSArray *inputVariables;
@property ALFuzzyVariable *outputVariable;

+ (ALFuzzyRuleTemplate *) templateWithInputVariables : (NSArray *) vars andOutputVariabe : (ALFuzzyVariable *) outputVar;

- (ALFuzzyRule *) ruleWithInputValues : (NSArray *) values andResult : (ALFuzzySet *) output;
- (ALCompoundStatement *) scenarioWithValues : (NSArray *) values;

@end
