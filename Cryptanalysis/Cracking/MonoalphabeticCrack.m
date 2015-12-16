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
            int actualSubstitutions = (int)[table count];
            
            [MonoalphabeticCrack fillTable:&table fromWords:words];
                
            if ([table count] == actualSubstitutions)
                break;
        }
    }
    return [MonoalphabeticCrack makeKey:table];
}


+ (void)fillTable:(NSDictionary **)table fromWords:(NSArray *)words {
    
    NSString * actualKey = [MonoalphabeticCrack makeKey:*table];
    NSString * decryptedText = [Monoalphabetic decrypt:[words componentsJoinedByString:@" "] withKey:actualKey];
    NSArray * decryptedWords = [decryptedText componentsSeparatedByString:@" "];
    NSArray * filteredWords = [MonoalphabeticCrack filterArray:decryptedWords numberOfUnknownChars:1];
    FileReader * reader;
    NSString * word, * pattern;
    NSRegularExpression * regex;
    int actualSubstitutions = (int)[*table count];
    
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
                    int pos = (int)[[word componentsSeparatedByString:@"*"][0] length];
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
    int size = (int)MIN([word length], [subs length]);
    
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
    NSMutableArray * key = [[Utils makeNumberArrayWith:LETTER_COUNT] mutableCopy];
    NSMutableArray * frequency = [[Utils lettersFrequency:text] mutableCopy];
    NSMutableArray * expected = [Language.expectedFrequency mutableCopy];
    
    //NSLog(@"freq: %@ \n expe: %@", frequency, Language.expectedFrequency);
    /*
    for (char i = 0; i < LETTER_COUNT; i++) {
        NSNumber * max = [frequency valueForKeyPath:@"@max.self"];
        int maxIndex = [frequency indexOfObject:max];
        
        NSNumber * maxExpected = [expected valueForKeyPath:@"@max.self"];
        int maxIndexExpected = [expected indexOfObject:maxExpected];
        
        result[maxIndexExpected] = [NSString stringWithFormat:@"%c", 'a' + maxIndex];
        frequency[maxIndex] = @(-1);
        expected[maxIndexExpected] = @(-1);
    }
     */
    [MonoalphabeticCrack addKeysFromFrequency:frequency expected:expected
                             resultInProgress:[key mutableCopy] charsLeft:LETTER_COUNT
                                  finalResult:&result];
    
    
    return [MonoalphabeticCrack findMostProbableKey:text fromKeys:result];
    
    
}

+ (NSString *)findMostProbableKey:(NSString *)text fromKeys:(NSArray *)keys {
    
    NSString * bestGuess = keys[0];
    int bestValue = 0;
    
    for (NSString * key in keys) {
        @autoreleasepool {
            NSString * decrypted = [Monoalphabetic decrypt:text withKey:key];
            int realWordsCount = [Utils realWordsCount:decrypted];
            
            if (realWordsCount > bestValue) {
                bestValue = realWordsCount;
                bestGuess = key;
            }
        }
    }
    return bestGuess;
}


+ (void)addKeysFromFrequency:(NSMutableArray *)freq expected:(NSMutableArray *)exp resultInProgress:(NSMutableArray *)res charsLeft:(int)charsLeft finalResult:(NSMutableArray **)result {
    
    for (char i = 0; i < charsLeft; i++) {
        NSNumber * max = [freq valueForKeyPath:@"@max.self"];
        int maxIndex = [freq indexOfObject:max];
        NSNumber * maxExpected = [exp valueForKeyPath:@"@max.self"];
        int maxIndexExpected = [exp indexOfObject:maxExpected];
        
        if (fabs([max floatValue] - [maxExpected floatValue]) > 0.1) {
            res[maxIndexExpected] = [NSString stringWithFormat:@"%c", 'a' + maxIndex];
            freq[maxIndex] = @(-1);
            exp[maxIndexExpected] = @(-1);
        }
        else {
            freq[maxIndex] = @(-1);
            NSNumber * newMax = [freq valueForKeyPath:@"@max.self"];
            int newMaxIndex = [freq indexOfObject:newMax];
            
            if (maxIndex == newMaxIndex) return;
            
            freq[newMaxIndex] = [NSNumber numberWithFloat:[max floatValue] + 2];;
            freq[maxIndex] = newMax;
            
            [MonoalphabeticCrack addKeysFromFrequency:[freq mutableCopy] expected:[exp mutableCopy]
                                     resultInProgress:[res mutableCopy] charsLeft:(charsLeft - i)
                                          finalResult:result];
            
            res[maxIndexExpected] = [NSString stringWithFormat:@"%c", 'a' + maxIndex];
            freq[maxIndex] = @(-1);
            exp[maxIndexExpected] = @(-1);
        }
    }
    
    [*result addObject:[res componentsJoinedByString:@""]];
}






+ (NSString *)keyGuess:(NSString *)text {
    return [MonoalphabeticCrack uniqueWordsKeyGuess:text];
}

+ (NSString *)breakCodedText:(NSString *)text {
    return [Monoalphabetic decrypt:text
                           withKey:[MonoalphabeticCrack keyGuess:text]];
}

+ (bool)isGuessedKey:(NSString *)guess equalToKey:(NSString *)key {
    
    if ([key length] != [guess length])
        return false;
    
    int allowedDifference = 8;
    
    for (int i = 0; i < [key length]; i++)
        if ([key characterAtIndex:i] != [guess characterAtIndex:i])
            allowedDifference--;
    
    return allowedDifference >= 0;
}


@end
