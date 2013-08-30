//
//  ALFuzzyRuleTemplate.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 7/22/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALFuzzyRuleTemplate.h"
#import "ALFuzzyRule.h"
#import "ALFuzzyVariable.h"
#import "ALFuzzySet.h"
#import "ALAtomicStatement.h"
#import "ALCompoundStatement.h"

@implementation ALFuzzyRuleTemplate

+ (ALFuzzyRuleTemplate *)templateWithInputVariables:(NSArray *)vars andOutputVariabe:(ALFuzzyVariable *)outputVar {
    ALFuzzyRuleTemplate *template = [ALFuzzyRuleTemplate new];
    template.inputVariables = [NSArray arrayWithArray:vars];
    template.outputVariable = outputVar;
    return template;
}

- (ALFuzzyRule *)ruleWithInputValues:(NSArray *)values andResult:(ALFuzzySet *)output {
    ALFuzzyRule *rule = [ALFuzzyRule new];
    NSUInteger count = [_inputVariables count];
    NSMutableArray *arr = [NSMutableArray array];
    for (int index = 0; index < count; ++index) {
        [arr addObject:[ALAtomicStatement stmWithVariable:[_inputVariables objectAtIndex:index] andFuzzySet:[values objectAtIndex:index]]];
    }
    rule.cause = [ALCompoundStatement stmWithAtomicStatements:arr];
    rule.result = [ALAtomicStatement stmWithVariable:_outputVariable andFuzzySet:output];
    return rule;
}

- (ALCompoundStatement *)scenarioWithValues:(NSArray *)values {
    NSUInteger count = [_inputVariables count];
    NSMutableArray *arr = [NSMutableArray array];
    for (int index = 0; index < count; ++index) {
        [arr addObject:[ALAtomicStatement stmWithVariable:[_inputVariables objectAtIndex:index] andFuzzySet:[values objectAtIndex:index]]];
    }
    return [ALCompoundStatement stmWithAtomicStatements:arr];
}

@end
