//
//  ALExplanation.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 7/20/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defs.h"

@interface ALBinaryDecisionEvaluationResult : NSObject

@property NSMutableArray *matchingRules;    // ALFuzzyRule objects that match the given scenario with a non-negligible result (includes both positive and negative rules)
@property NSMutableArray *rulesMatchingDegrees;  // results (NSNUmbers between 0.0 and 1.0) of applying above rules to given scenario
@property NSNumber *totalPositive;  // total of positive results
@property NSNumber *totalNegative; // total of negative results
@property EvaluationResult finalResult;

@end
