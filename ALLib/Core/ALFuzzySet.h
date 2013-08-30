//
//  ALFuzzySet.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/8/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALFuzzyUniverse;

@interface ALFuzzySet : NSObject

@property ALFuzzyUniverse *universe;
@property NSMutableDictionary *possibilities;   // key = value (from universe)   value = possibility

- (void) setPossibilityFunction : (NSNumber* (^) (NSNumber *)) func;

@end
