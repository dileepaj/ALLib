//
//  Fuzzy1To5.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 7/22/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALFuzzyUniverse.h"
#import "ALFuzzySet.h"
#import "ALFuzzyVariable.h"

@interface Fuzzy1To5Universe : ALFuzzyUniverse

@end

@interface Fuzzy1To5Variable : ALFuzzyVariable

@end

@interface Fuzzy1To5VeryLow : ALFuzzySet

@end

@interface Fuzzy1To5Low : ALFuzzySet

@end

@interface Fuzzy1To5Medium : ALFuzzySet

@end

@interface Fuzzy1To5High : ALFuzzySet

@end

@interface Fuzzy1To5VeryHigh : ALFuzzySet

@end

@interface Fuzzy1To5 : NSObject

+ (ALFuzzySet *) fuzzySetWithValue : (NSUInteger) val;

@end
