//
//  Defs.h
//  ALLib
//
//  Created by Dileepa Jayathilake on 4/9/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ni(x)       [NSNUmber numberWithInt:x]
#define nf(x)       [NSNumber numberWithDouble:x]
#define zero        nf(0.0)
#define one         nf(1.0)

typedef enum _EvaluationResult {
    EvaluationResult_Yes,
    EvaluationResult_No,
    EvaluationResult_Indeterminate
} EvaluationResult;
