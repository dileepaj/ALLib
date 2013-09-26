ALLib
=====

ALLib is the first fuzzy logic library that is publicly available in Objective C.

http://www.approximatelogic.com/documentation.html

A fuzzy system represents one particular problem that you want to solve in your app using fuzzy logic. In order to use a fuzzy system to solve problems you first need to define the system and then prepare it.

Example scenario
In the sections that describe steps to wire up a fuzzy system we will use the following example for illustration.

We are going to use a fuzzy system to provide us a suggestion on whether or not to hire a candidate for a job by looking at his / her experience level, education and salary expectation. Hereafter we will call them ‘factors’. During the interview process the interviewers will give a score from 1 to 5 for each of these 3 factors. After the interview the 3 scores will be fed to the fuzzy system, which will output yes or no.
During the training process we will use fuzzy concepts ‘very low’, ‘low’, ‘medium’, ‘high’ and ‘very high’ to to express our subjective evaluation on how big a factor is in a given case. For example “experience is medium, education is high and salary expectation is very high”.

Defining a fuzzy system
First step in defining a fuzzy system is to define the fuzzy universes involved. A fuzzy universe is a collection of all the values that a related group of fuzzy variables in the system can take. For this purpose, it’s beneficial to first identify the fuzzy variables involved. 
In the example case we can easily identify 4 fuzzy variables in the picture.
1.	Experience level
2.	Education level
3.	Salary expectation
4.	Decision (whether or not to hire the guy)
Each of the first 3 variables can take integer values from 1 to 5. Forth one is different; it can take one of two values -> yes or no.

This analysis puts us in the perspective that there should be 2 fuzzy universes in the system.
1.	For the first 3 variables, a fuzzy universe consisting of integers 1, 2, 3, 4, 5 (input universe)
2.	For the 4th one, a fuzzy universe consisting the values yes, no (output universe)

We create the 2 universes as follows.

ALFuzzyUniverse *inputUniverse = [ALFuzzyUniverse new];
inputUniverse.values = (NSMutableArray *) @[nf(1.0), nf(2.0), nf(3.0), nf(4.0), nf(5.0)];
    
ALFuzzyUniverse *outputUniverse = [ALFuzzyUniverse new];
outputUniverse.values = (NSMutableArray *) @[zero, one];

Here nf is a convenience macro that makes an NSNumber with a float value. It is defined in the library as follows.

define nf(x)       [NSNumber numberWithDouble:x]

zero and one are also defined for convenience as follows.

define zero        nf(0.0)
define one         nf(1.0)

After that we can define the fuzzy variables involved. As mentioned earlier there are 3 input variables (experience, education and salary expectation) and 1 output variable (decision). The 3 input variables belong to the input universe whereas the output variable belongs to output universe.

// Create input variables
ALFuzzyVariable *experience = [ALFuzzyVariable new];
experience.universe = inputUniverse;
    
ALFuzzyVariable *education = [ALFuzzyVariable new];
education.universe = inputUniverse;
    
ALFuzzyVariable *salaryExpectation = [ALFuzzyVariable new];
salaryExpectation.universe = inputUniverse;
    
// Create the output variable
ALFuzzyVariable *decision = [ALFuzzyVariable new];
decision.universe = outputUniverse;

Then we create the fuzzy sets. We use the following membership functions in doing so.

<include graphs for all 5 fuzzy sets>

// Craete fuzzy sets for input variables
    ALFuzzySet *veryhigh = [ALFuzzySet new];
    veryhigh.universe = inputUniverse;
    veryhigh.possibilities = (NSMutableDictionary *) @{nf(1.0) : nf(0.0),
    nf(2.0) : nf(0.0625),
    nf(3.0) : nf(0.25),
    nf(4.0) : nf(0.5625),
    nf(5.0) : nf(1.0)
    };
    
    ALFuzzySet *high = [ALFuzzySet new];
    high.universe = inputUniverse;
    high.possibilities = (NSMutableDictionary *) @{nf(1.0) : nf(0.0),
    nf(2.0) : nf(0.25),
    nf(3.0) : nf(0.5),
    nf(4.0) : nf(0.75),
    nf(5.0) : nf(1.0)
    };
    
    ALFuzzySet *medium = [ALFuzzySet new];
    medium.universe = inputUniverse;
    medium.possibilities = (NSMutableDictionary *) @{nf(1.0) : nf(0.0),
    nf(2.0) : nf(0.5),
    nf(3.0) : nf(1.0),
    nf(4.0) : nf(0.5),
    nf(5.0) : nf(0.0)
    };
    
    ALFuzzySet *low = [ALFuzzySet new];
    low.universe = inputUniverse;
    low.possibilities = (NSMutableDictionary *) @{nf(1.0) : nf(1.0),
    nf(2.0) : nf(0.75),
    nf(3.0) : nf(0.5),
    nf(4.0) : nf(0.25),
    nf(5.0) : nf(0.0)
    };
    
    ALFuzzySet *verylow = [ALFuzzySet new];
    verylow.universe = inputUniverse;
    verylow.possibilities = (NSMutableDictionary *) @{nf(1.0) : nf(1.0),
    nf(2.0) : nf(0.5625),
    nf(3.0) : nf(0.25),
    nf(4.0) : nf(0.0625),
    nf(5.0) : nf(0.0)
    };

// Create fuzzy sets for output variables
    ALFuzzySet *yes = [ALFuzzySet new];
    yes.universe = outputUniverse;
    yes.possibilities = (NSMutableDictionary *) @{zero : zero, one : one};
    
    ALFuzzySet *no = [ALFuzzySet new];
    no.universe = outputUniverse;
    no.possibilities = (NSMutableDictionary *) @{zero : one, one : zero};

When creating a fuzzy set we need to specify the universe it operates on and its membership function (the property ‘possibilities’). Membership function is specified as a dictionary where the key is a number from the fuzzy universe and the value for that key is the possibility for that number. For instance, in the fuzzy set ‘very high’ the number 3 has a possibility value of 0.25 (in other words, the number has a 0.25 membership in the fuzzy concept ‘very high’). For all values in the universe where a possibility value is not defined in the membership function, possibility is assumed to be zero.

Instead of specifying the membership function as a dictionary, it is also possible to have it as a Objective C block that takes a number as its parameter and outputs the possibility. This is useful in cases where there are lots of values in the universe and specifying possibility values one by one is laborious. However, this approach is a bit less efficient than the dictionary as the possibilities need to be calculated at runtime.
For example, we could define the possibility function for ‘very low’ as follows.

[verylow setPossibilityFunction:^NSNumber *(NSNumber *value) {
        double x = ([value doubleValue] - 1.0) / 4.0;
        return nf(x * x);
    }];

Now we have completed wiring up the basic elements of our fuzzy system. Next step is to train it with known rules.

Training the system
Before using the fuzzy system for solving problems we need to feed it with knowledge regarding the problem in terms of rules. We call this a rulebase. Rulebase is typically formed by a team brainstorming on the problem. You can use the “Decision Space” library to facilitate this process. Here we will illustrate how to train the system with 3 rules (though in practice, a lot more than 3 rules is needed to train a system to perform in a good level)

	Experience	Education	Salary Expectation	Decision (Hire?)
Rule 1	High	Medium	High	Yes
Rule 2	Medium	Very High	Very High	No
Rule 3	Low	High	Low	Yes

// Create fuzzy sets for output variables
    ALFuzzySet *yes = [ALFuzzySet new];
    yes.universe = outputUniverse;
    yes.possibilities = (NSMutableDictionary *) @{zero : zero, one : one};
    	
    ALFuzzySet *no = [ALFuzzySet new];
    no.universe = outputUniverse;
    no.possibilities = (NSMutableDictionary *) @{zero : one, one : zero};
    
    // Create rule set
    ALFuzzyRule *rule1 = [ALFuzzyRule ruleWithCause:[ALCompoundStatement stmWithAtomicStatements:@[
    [ALAtomicStatement stmWithVariable:experience andFuzzySet:high],
    [ALAtomicStatement stmWithVariable:education andFuzzySet:medium],
    [ALAtomicStatement stmWithVariable:salaryExpectation andFuzzySet:high]]]
                                          andResult:[ALAtomicStatement stmWithVariable:decision andFuzzySet:yes]];
    
    ALFuzzyRule *rule2 = [ALFuzzyRule ruleWithCause:[ALCompoundStatement stmWithAtomicStatements:@[
                                                     [ALAtomicStatement stmWithVariable:experience andFuzzySet:medium],
                                                     [ALAtomicStatement stmWithVariable:education andFuzzySet:veryhigh],
                                                     [ALAtomicStatement stmWithVariable:salaryExpectation andFuzzySet:veryhigh]]]
                                          andResult:[ALAtomicStatement stmWithVariable:decision andFuzzySet:no]];
    
    ALFuzzyRule *rule3 = [ALFuzzyRule ruleWithCause:[ALCompoundStatement stmWithAtomicStatements:@[
                                                     [ALAtomicStatement stmWithVariable:experience andFuzzySet:low],
                                                     [ALAtomicStatement stmWithVariable:education andFuzzySet:high],
                                                     [ALAtomicStatement stmWithVariable:salaryExpectation andFuzzySet:low]]]
                                          andResult:[ALAtomicStatement stmWithVariable:decision andFuzzySet:yes]];
    
    ALFuzzyRuleSet *ruleSet = [ALFuzzyRuleSet rulesetWithRules:@[rule1, rule2, rule3]];


Now we create a fuzzy evaluator object (which stands for a fuzzy system) with these rules.

// Create the evaluator
    ALFuzzyEvaluator *evaluator = [ALFuzzyEvaluator new];
    evaluator.ruleSet = ruleSet;

This evaluator is now ready to answer our questions.

Using the trained fuzzy system for problem solving
In an interview our interviewers give marks to candidates from 1 to 5 for each factor. Let’s say, in one such interview, we got following scores.

Experience = 4
Education = 3
Salary Expectation = 2

With these values we should ask our fuzzy system whether the candidate is good enough to be hired. We have to ask the question in terms of fuzzy sets. For this we create 3 new fuzzy sets to represent the current scenario. For example, to represent Experience = 4, we create a fuzzy set where the value 4.0 has a possibility of 1.0 whereas all other values have possibility zero.

// ask a question
    ALFuzzySet *value4 = [ALFuzzySet new];
    value4.universe = inputUniverse;
    value4.possibilities = (NSMutableDictionary *) @{nf(4.0) : one};
    
    ALFuzzySet *value3 = [ALFuzzySet new];
    value3.universe = inputUniverse;
    value3.possibilities = (NSMutableDictionary *) @{nf(3.0) : one};
    
    ALFuzzySet *value2 = [ALFuzzySet new];
    value2.universe = inputUniverse;
    value2.possibilities = (NSMutableDictionary *) @{nf(2.0) : one};
    
    ALFuzzySet *result = [evaluator evaluateCase:[ALCompoundStatement stmWithAtomicStatements:@[[ALAtomicStatement stmWithVariable:experience andFuzzySet:value4], [ALAtomicStatement stmWithVariable:education andFuzzySet:value3], [ALAtomicStatement stmWithVariable:salaryExpectation andFuzzySet:value2]]]];
    
    double possibilityYes = [[result.possibilities objectForKey:zero] doubleValue];
    double possibilityNo = [[result.possibilities objectForKey:one] doubleValue];
    
    BOOL shouldHireTheCandidate = (possibilityYes > possibilityNo);

Result of evaluateCase method is a fuzzy set in the output universe. We decide whether or not to hire based on whether the yes value (possibility of the value 1) is greater than no value (possibility of the value 0).

evaluateCase method is a generic way to evaluate any fuzzy problem. However, for binary decision making problems (where the decision is either yes or no) we have a better evaluation method. Since our problem of concern is also a binary decision making problem we can apply that instead of evaluateCase.

ALBinaryDecisionEvaluationResult *binaryResult = [evaluator evaluateBinaryDecisionCase:[ALCompoundStatement stmWithAtomicStatements:@[
                                                                                            [ALAtomicStatement stmWithVariable:experience andFuzzySet:value4],
                                                                                            [ALAtomicStatement stmWithVariable:education andFuzzySet:value3],
                                                                                            [ALAtomicStatement stmWithVariable:salaryExpectation andFuzzySet:value2]]]];
    shouldHireTheCandidate = binaryResult.finalResult == EvaluationResult_Yes;

ALBinaryDecisionEvaluationResult class provides lot of other useful information regarding the decision.

