//
//  FuzzySystemTest1.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/19/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class ALFuzzyEvaluator;
@class ALFuzzyUniverse;
@class ALFuzzyVariable;

@interface FuzzySystemTest1 : SenTestCase {
    ALFuzzyEvaluator *eval;
    ALFuzzyUniverse *universe;
    ALFuzzyUniverse *outputUniverse;
    ALFuzzyVariable *p1;
    ALFuzzyVariable *p2;
    ALFuzzyVariable *p3;
}

@end
