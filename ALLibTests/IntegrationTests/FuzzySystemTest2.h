//
//  FuzzySystemTest2.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/21/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class ALFuzzyEvaluator;
@class ALFuzzyUniverse;
@class ALFuzzyVariable;
@class ALFuzzySet;

@interface FuzzySystemTest2 : SenTestCase {
    ALFuzzyEvaluator *eval;
    ALFuzzyUniverse *universe;
    ALFuzzyUniverse *universe2;
    ALFuzzyUniverse *outputUniverse;
    ALFuzzyVariable *p1;
    ALFuzzyVariable *p2;
    ALFuzzyVariable *p3;
    ALFuzzyVariable *decision;
    ALFuzzySet *verylow;
    ALFuzzySet *low;
    ALFuzzySet *medium;
    ALFuzzySet *high;
    ALFuzzySet *veryhigh;
    ALFuzzySet *verylow2;
    ALFuzzySet *low2;
    ALFuzzySet *medium2;
    ALFuzzySet *high2;
    ALFuzzySet *veryhigh2;
}

@end
