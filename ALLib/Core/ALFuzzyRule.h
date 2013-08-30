//
//  ALFuzzyRule.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALSemantic_IfThen.h"

@class ALCompoundStatement;
@class ALAtomicStatement;
@class ALFuzzySet;

@interface ALFuzzyRule : NSObject {
    id<ALSemantic_IfThen> ifThenOperator;
}

@property ALCompoundStatement *cause;
@property ALAtomicStatement *result;        // IF (cause) THEN (result)

+ (ALFuzzyRule *) ruleWithCause : (ALCompoundStatement *) cause andResult : (ALAtomicStatement *) result;

- (void) setIfThenOperator : (id<ALSemantic_IfThen>) op;
- (ALFuzzySet *) evaluateForCase : (ALCompoundStatement *) input;

@end
