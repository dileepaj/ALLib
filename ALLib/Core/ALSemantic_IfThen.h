//
//  ALSemantic_IfThen.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/9/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALFuzzySet;

@protocol ALSemantic_IfThen <NSObject>

- (ALFuzzySet *) evaluateIf : (NSNumber *) condition withThen: (ALFuzzySet *) action;

@end
