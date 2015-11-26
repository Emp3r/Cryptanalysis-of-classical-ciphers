#import "MonoalphabeticCrack.h"
#import "Monoalphabetic.h"
#import "Utils.h"
#import "Language.h"
#import "Storage.h"
#import "FileReader.h"

@interface StringPair : NSObject
    @property (strong) NSString * x;
    @property (strong) NSString * y;
@end
@implementation StringPair
    @synthesize x, y;
@end


@implementation MonoalphabeticCrack

// unique words attack
+ (NSString *)uniqueWordsKeyGuess:(NSString *)text {
    return nil;
}

+ (NSDictionary *)findMatchesWithUniqueWords:(NSString *)text {
    
    text = [Utils normalizeLeaveSpaces:text];
    NSMutableDictionary * matches = [[NSMutableDictionary alloc] init];
    NSMutableArray * m = [[NSMutableArray alloc] init];
    
    NSArray * words = [text componentsSeparatedByString:@" "];
    NSArray * uniques = [MonoalphabeticCrack getAllUniqueWords];
    
    for (NSString * u in uniques)
        [matches setObject:u forKey:[Utils getCanonicalForm:u]];
    
    
    int num = 0;;
    for (NSString * w in words) {
        for (NSString * u in uniques) {
            @autoreleasepool {
                if ([[Utils getCanonicalForm:w] isEqualToString:[Utils getCanonicalForm:u]]) {
                    StringPair * newPair = [[StringPair alloc] init];
                    newPair.x = u, newPair.y = w;
                    [m addObject:newPair];
                }
                num++;
            }
        }
    }
    // TODO
    // uncomplete stuff
    
    
    num++;
    return matches;
}


+ (NSArray *)getAllUniqueWords {
    
    NSMutableArray * words = [[NSMutableArray alloc] init];
    FileReader * reader = [Storage getUniqueFileReader];
    
    NSString * line = nil;
    while ((line = [reader readLine])) {
        line = [Utils removeWhiteEnd:line];
        [words addObject:line];
    }
    return words;
}


// frequency analysis
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
