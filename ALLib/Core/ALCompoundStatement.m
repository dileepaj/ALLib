//
//  ALCompoundStatement.m
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "ALCompoundStatement.h"
#import "ALAtomicStatement.h"
#import "ALMinimum.h"

@implementation ALCompoundStatement

- (id) init {
    self = [super init];
    if (self) {
        andOperator = [ALMinimum new];
    }
    return self;
}

+ (ALCompoundStatement *)stmWithAtomicStatements:(NSArray *)atomicStatements {
    ALCompoundStatement *cs = [ALCompoundStatement new];
    cs.statements = [NSArray arrayWithArray:atomicStatements];
    return cs;
}

- (void)setAndOperator:(id<ALSemantic_And>)op {
    andOperator = op;
}

- (NSArray *)getCompositionWith:(ALCompoundStatement *)cs {
    NSMutableArray *ret = [NSMutableArray array];
    NSUInteger count = [self.statements count];
    for (int index = 0; index < count; ++index) {
        ALAtomicStatement *as1 = [self.statements objectAtIndex:index];
        ALAtomicStatement *as2 = [cs.statements objectAtIndex:index];
        [ret addObject:[as1 getCompositionWithSet:as2.set]];
    }
    return ret;
}

- (NSNumber *)getCompositionFollowedByAnd:(ALCompoundStatement *)cs {
    NSArray *compositionResult = [self getCompositionWith:cs];
    return [andOperator getAnd:compositionResult];
}

@end
