#import "MonoalphabeticCrack.h"
#import "Monoalphabetic.h"
#import "Utils.h"
#import "Language.h"
#import "Storage.h"

@implementation MonoalphabeticCrack

// unique words attack
+ (NSString *)uniqueWordsKeyGuess:(NSString *)text {
    
    text = [Utils normalizeLeaveSpaces:text];
    NSArray * words = [[NSOrderedSet orderedSetWithArray:[text componentsSeparatedByString:@" "]] array];
    NSDictionary * matches = [MonoalphabeticCrack findMatchesWithUniqueWords:words];
    NSArray * clique = [MonoalphabeticCrack findLargestClique:matches];
    NSDictionary * table = [MonoalphabeticCrack uniteTables:clique];
    
    while ([table count] < LETTER_COUNT) {
        @autoreleasepool {
            int actualSubstitutions = [table count];
            
            [MonoalphabeticCrack fillTable:&table fromWords:words];
                
            if ([table count] == actualSubstitutions)
                break;
        }
    }
    return [MonoalphabeticCrack makeKey:table];
}


+ (void)fillTable:(NSDictionary **)table fromWords:(NSArray *)words {
    
    NSString * actualKey = [MonoalphabeticCrack makeKey:*table];
    NSString * decryptedText = [Monoalphabetic decrypt:[words componentsJoinedByString:@" "] with:actualKey];
    NSArray * decryptedWords = [decryptedText componentsSeparatedByString:@" "];
    NSArray * filteredWords = [MonoalphabeticCrack filterArray:decryptedWords numberOfUnknownChars:1];
    FileReader * reader;
    NSString * word, * pattern;
    NSRegularExpression * regex;
    int actualSubstitutions = [*table count];
    
    for (int i = 0; i < [filteredWords count]; i++) {
        word = filteredWords[i];
        reader = [Storage dictionaryFileReader];
        pattern = [NSString stringWithFormat:@"^%@$", [word stringByReplacingOccurrencesOfString:@"*" withString:@"."]];
        regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSString * line = nil;
        while ((line = [reader readLine])) {
            @autoreleasepool {
                line = [Utils removeWhiteEnd:line];
                
                if ([regex firstMatchInString:line options:0 range:NSMakeRange(0, [line length])]) {
                    // add substitution to table (if not there) and stop
                    NSArray * splitted = [word componentsSeparatedByString:@"*"];
                    int pos = [splitted[0] length];
                    char original = [words[[decryptedWords indexOfObject:word]] characterAtIndex:pos];
                    NSString * o = [NSString stringWithFormat:@"%c", original];
                    NSString * s = [NSString stringWithFormat:@"%c", [line characterAtIndex:pos]];
                    
                    if (![[*table allKeys] containsObject:s] && ![[*table allValues] containsObject:o]) {
                        [*table setValue:o forKey:s];
                        break;
                    }
                }
            }
        }
        if ([*table count] != actualSubstitutions) break;
    }
}

+ (NSArray *)filterArray:(NSArray *)array numberOfUnknownChars:(int)count {
    
    NSMutableArray * filteredArray = [[NSMutableArray alloc] init];
    NSString * pattern = [NSString stringWithFormat:@"^[^\\*]*(\\*[^\\*]*){%d}$", count];
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    for (NSString * word in array)
        if ([regex firstMatchInString:word options:0 range:NSMakeRange(0, [word length])])
            [filteredArray addObject:word];
    
    return [[NSOrderedSet orderedSetWithArray:filteredArray] array];
}


+ (NSString *)makeKey:(NSDictionary *)table {
    
    NSMutableString * result = [[NSMutableString alloc] init];
    
    for (int i = 0; i < LETTER_COUNT; i++) {
        NSString * letter = [NSString stringWithFormat:@"%c", ('a' + i)];
        
        if ([[table allKeys] containsObject:letter])
            [result appendString:table[letter]];
        else
            [result appendString:@"*"];
    }
    return result;
}


+ (NSDictionary *)uniteTables:(NSArray *)tables {
    
    NSMutableDictionary * unitedTable = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary * t in tables)
        [unitedTable addEntriesFromDictionary:t];
    
    return unitedTable;
}

+ (NSArray *)findLargestClique:(NSDictionary *)pairs {
    
    NSMutableArray * clique = [[NSMutableArray alloc] init];
    NSMutableArray * tables = [[NSMutableArray alloc] init];
    
    for (NSString * k in [pairs allKeys])
        [tables addObject:[MonoalphabeticCrack makeSubstitutionTable:k subs:pairs[k]]];
    
    for (int i = 0; i < ([tables count] - 1); i++) {
        @autoreleasepool {
            NSMutableArray * temp = [NSMutableArray arrayWithObject:tables[i]];
            
            for (int j = (i + 1); j < [tables count]; j++) {
                bool hasSameTable = true;
                
                for (NSDictionary * d in temp)
                    if (![MonoalphabeticCrack hasSameSubstitutionTables:d and:tables[j]])
                        hasSameTable = false;
                
                if (hasSameTable)
                    [temp addObject:tables[j]];
            }
            
            if ([temp count] > [clique count])
                clique = [temp copy];
        }
    }
    return clique;
}


+ (NSDictionary *)findMatchesWithUniqueWords:(NSArray *)words {
    
    NSMutableDictionary * matches = [[NSMutableDictionary alloc] init];
    NSArray * uniques = [Storage getAllUniqueWords];
    
    for (NSString * w in words) {
        @autoreleasepool {
            if (![[matches allKeys] containsObject:w]) {
                for (NSString * u in uniques) {
                    if ([[Utils getCanonicalForm:w] isEqualToString:[Utils getCanonicalForm:u]]) {
                        [matches setObject:u forKey:w];
                        break;
                    }
                }
            }
        }
    }
    return matches;
}

+ (NSDictionary *)makeSubstitutionTable:(NSString *)word subs:(NSString *)subs {
    
    NSMutableDictionary * result = [[NSMutableDictionary alloc] init];
    int size = MIN([word length], [subs length]);
    
    for (int i = 0; i < size; i++) {
        [result setObject:[NSString stringWithFormat:@"%c", [word characterAtIndex:i]]
                   forKey:[NSString stringWithFormat:@"%c", [subs characterAtIndex:i]]];
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
