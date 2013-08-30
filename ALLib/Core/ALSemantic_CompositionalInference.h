//
//  ALSemantic_CompositionalInference.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/9/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALFuzzySet;

@protocol ALSemantic_CompositionalInference <NSObject>

- (NSNumber *) getCompositionalInferenceOfSet : (ALFuzzySet *) set1 withSet : (ALFuzzySet *) set2;

@end
