//
//  ALSemantic_Also.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/9/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALFuzzySet;

@protocol ALSemantic_Also <NSObject>

- (ALFuzzySet *) evualuateAlso : (NSArray *) sets;

@end
