//
//  ALAtomicStatementTests.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 8/21/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALAtomicStatementTests.h"
#import "ALIncludes.h"
#import <OCMock/OCMock.h>

@implementation ALAtomicStatementTests

- (void)setUp {
    as = [ALAtomicStatement new];
}

- (void)tearDown {
    as = nil;
}

- (void) testsetCompositionOperator_withNilArgument_shouldNotThrow {
    STAssertNoThrow([as setCompositionOperator:nil], @"");
}

- (void) testgetCompositionWithSet_withNilCompositionOperator_shouldNotThrow {
    [as setCompositionOperator:nil];
    STAssertNoThrow([as getCompositionWithSet:[ALFuzzySet new]], @"");
}

- (void) testgetCompositionWithSet_withNilSet_shouldNotThrow {
    STAssertNoThrow([as getCompositionWithSet:nil], @"");
}

- (void) testgetCompositionWithSet_withCorrectArguments_callsgetCompositionalInferenceOfSet {
    id co = [OCMockObject niceMockForProtocol:@protocol(ALSemantic_CompositionalInference)];
    [as setCompositionOperator:co];
    [[co expect] getCompositionalInferenceOfSet:[OCMArg any] withSet:[OCMArg any]];
    [as getCompositionWithSet:nil];
    [co verify];
}

- (void) testgetCompositionWithSet_withCorrectArguments_callsgetCompositionalInferenceOfSetWithCorrectSet1 {
    id set = [OCMockObject niceMockForClass:[ALFuzzySet class]];
    as.set = set;
    id co = [OCMockObject niceMockForProtocol:@protocol(ALSemantic_CompositionalInference)];
    [as setCompositionOperator:co];
    [[co expect] getCompositionalInferenceOfSet:set withSet:[OCMArg any]];
    [as getCompositionWithSet:nil];
    [co verify];
}

- (void) testgetCompositionWithSet_withCorrectArguments_callsgetCompositionalInferenceOfSetWithCorrectSet2 {
    id set = [OCMockObject niceMockForClass:[ALFuzzySet class]];
    id co = [OCMockObject niceMockForProtocol:@protocol(ALSemantic_CompositionalInference)];
    [as setCompositionOperator:co];
    [[co expect] getCompositionalInferenceOfSet:[OCMArg any] withSet:set];
    [as getCompositionWithSet:set];
    [co verify];
}

@end
