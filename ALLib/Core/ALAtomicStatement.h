//
//  ALAtomicStatement.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALSemantic_CompositionalInference.h"

@class ALFuzzyVariable;
@class ALFuzzySet;

@interface ALAtomicStatement : NSObject {
    id<ALSemantic_CompositionalInference> compositionOperator;
}

@property ALFuzzyVariable *variable;
@property ALFuzzySet *set;

+ (ALAtomicStatement *) stmWithVariable : (ALFuzzyVariable *) var andFuzzySet : (ALFuzzySet *) set;

- (void) setCompositionOperator : (id<ALSemantic_CompositionalInference>) op;
- (NSNumber *) getCompositionWithSet : (ALFuzzySet *) setToCompose;

@end
