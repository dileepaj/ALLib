//
//  ALCompoundStatement.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALSemantic_And.h"

@interface ALCompoundStatement : NSObject {
    id<ALSemantic_And> andOperator;
}

@property NSMutableArray *statements;   // array of atomic statements that are assumed to be connected by AND

+ (ALCompoundStatement *) stmWithAtomicStatements : (NSArray *) atomicStatements;

- (void) setAndOperator : (id<ALSemantic_And>) op;
- (NSNumber *) getCompositionFollowedByAnd : (ALCompoundStatement *) cs;

@end
