#import "MonoalphabeticCrack.h"
#import "Monoalphabetic.h"
#import "Utils.h"
#import "Language.h"
#import "Storage.h"
#import "FileReader.h"

@implementation MonoalphabeticCrack

// unique words attack
+ (NSString *)uniqueWordsKeyGuess:(NSString *)text {
    // TODO
    return nil;
}

+ (NSDictionary *)findMatchesWithUniqueWords:(NSString *)text {
    
    text = [Utils normalizeLeaveSpaces:text];
    NSMutableDictionary * matches = [[NSMutableDictionary alloc] init];
    NSArray * words = [text componentsSeparatedByString:@" "];
    NSArray * uniques = [MonoalphabeticCrack getAllUniqueWords];
    
    int num = 0;
    for (NSString * w in words) {
        for (NSString * u in uniques) {
            @autoreleasepool {

                if ([[Utils getCanonicalForm:w] isEqualToString:[Utils getCanonicalForm:u]])
                    if (![matches objectForKey:w])
                        [matches setObject:u forKey:w];
                
                num++;
            }
        }
    }
    // TODO
    // uncomplete stuff
    
    
    num++;
    
    NSLog(@"%@, %d", matches, [matches count]);
    
    
    
    return matches;
}

+ (NSDictionary *)makeSubstitutionTable:(NSString *)word subs:(NSString *)subs {
    
    NSMutableDictionary * result = [[NSMutableDictionary alloc] init];
    int size = MIN([word length], [subs length]);
    
    for (int i = 0; i < size; i++) {
        [result setObject:[NSString stringWithFormat:@"%c", [subs characterAtIndex:i]]
                   forKey:[NSString stringWithFormat:@"%c", [word characterAtIndex:i]]];
    }
    return result;
}

+ (bool)hasSameSubstitutionTables:(NSDictionary *)first and:(NSDictionary *)second {
    
    for (NSString * f in [first allKeys]) {
        NSString * value = [first objectForKey:f];
        NSString * s = [second objectForKey:f];
        
        if ((s && [s isEqualToString:value]) ||
            (!s && ![[second allValues] containsObject:value])) {
            continue;
        }
        else {
            return false;
        }
    }
    return true;
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
