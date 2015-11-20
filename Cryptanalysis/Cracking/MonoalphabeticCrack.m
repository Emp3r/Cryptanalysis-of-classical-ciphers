#import "MonoalphabeticCrack.h"
#import "Monoalphabetic.h"
#import "Language.h"
#import "Utils.h"

@implementation MonoalphabeticCrack



+ (NSString *)frequencyAnalysisKeyGuess:(NSString *)text {
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    NSArray * frequency = [Utils lettersFrequency:text];
    NSArray * expected = Language.expectedFrequency;
    
    bool freeLetters[LETTER_COUNT];
    for (char i = 0; i < LETTER_COUNT; i++) freeLetters[i] = true;
    
    NSLog(@"%@ \n %@", frequency, expected);
    
    for (char i = 0; i < LETTER_COUNT; i++) {
        
        float actualLetterFrequency = [frequency[i] floatValue];
        float smallestDifference = FLT_MAX;
        char bestLetterGuess = 0;
        
        for (char j = 0; j < LETTER_COUNT; j++) {
            float difference = fabsf(actualLetterFrequency - [expected[j] floatValue]);
            
            if (difference < smallestDifference && freeLetters[j]) {
                smallestDifference = difference;
                bestLetterGuess = j;
            }
            
        }
        
        freeLetters[bestLetterGuess] = false;
        [result addObject:[NSString stringWithFormat:@"%c", ('a' + bestLetterGuess)]];
    }
    
    return [result componentsJoinedByString:@""];
}




@end
