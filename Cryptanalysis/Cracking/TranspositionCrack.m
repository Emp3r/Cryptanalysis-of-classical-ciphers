#import "TranspositionCrack.h"
#import "Transposition.h"
#import "Utils.h"
#import "Language.h"
#import "Combinatorics.h"

@implementation TranspositionCrack


// brute force - real words count
+ (NSString *)realWordsAnalysisKeyGuess:(NSString *)text {

    NSString * normalized = [Utils normalize:text];
    NSArray * possibleKeys = [TranspositionCrack getAllKeysForText:normalized];
    NSString * bestGuess = @"a";
    int bestValue = 0;
    
    for (NSString * key in possibleKeys) {
        NSString * decrypted = [Transposition decrypt:normalized with:key];
        int realWordsCount = [Utils realWordsCount:decrypted];
        
        if (realWordsCount > bestValue) {
            bestValue = realWordsCount;
            bestGuess = key;
        }
    }
    return bestGuess;
}


+ (NSArray *)getAllKeysForText:(NSString *)text {
    
    int length = (int)[text length];
    NSArray * divisors = [Utils getDivisors:length max:8];
    
    return [TranspositionCrack getAllKeysWithLengths:divisors];
}

+ (NSArray *)getAllKeysWithLengths:(NSArray *)lengths {
    
    NSArray * result = [[NSArray alloc] init];
    
    for (NSNumber * n in lengths) {
        NSArray * permutations = [TranspositionCrack getAllPossibleKeysWithLength:[n intValue]];
        result = [result arrayByAddingObjectsFromArray:permutations];
    }
    
    return result;
}


+ (NSArray *)getAllPossibleKeysWithLength:(int)length {
    
    NSMutableArray * letters = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < length; i++)
        [letters addObject:[NSString stringWithFormat:@"%c", ('a' + i)]];
    
    return [Combinatorics getPermutationStrings:letters];;
}

+ (NSArray *)getAllPossibleKeysToLength:(int)length {
    
    NSArray * results = [[NSArray alloc] init];
    NSMutableArray * letters = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < length; i++) {
        [letters addObject:[NSString stringWithFormat:@"%c", ('a' + i)]];
        
        NSArray * permutations = [Combinatorics getPermutationStrings:letters];
        results = [results arrayByAddingObjectsFromArray:permutations];
    }
    
    return results;
}



// finding word attack
+ (NSString *)findingWordKeyGuess:(NSString *)text {
    
    text = [Utils normalize:text];
    NSString * bestGuess = @"a";
    //NSMutableArray * keys = [[NSMutableArray alloc] init];
    
    NSArray * keyLengths = [Utils getDivisors:[text length] min:4 max:15];
    NSMutableDictionary * pairs = [[NSMutableDictionary alloc] init];
    
    
    int i = 0;
    int r = 0;
    for (NSNumber * keyLength in keyLengths) {
        @autoreleasepool {
            NSArray * textRows = [Transposition getTextParts:text with:[keyLength intValue]];
            // OMG
            // change textRows to columns!
            //
            //
            // NSArray * words = [TranspositionCrack getAllWordsOfLength:[keyLength intValue]];
            NSArray * words = [[Language mostUsedWords] filteredArrayUsingPredicate:
                               [NSPredicate predicateWithFormat:@"length == %@", keyLength]];
            
            
            if (i == 0) {
                for (NSString * row in textRows) {
                    r++;
                    [pairs addEntriesFromDictionary:[TranspositionCrack getPairsOfWordsWithSameChars:words inText:row]];
                }
            }
            
            // NSLog(@": %@, %d", pairs, r);
            // [words[i] removeAllObjects];
        }
        i++;
    }
    NSLog(@": %@", pairs);
    
    return bestGuess;
}

+ (NSDictionary *)getPairsOfWordsWithSameChars:(NSArray *)words inText:(NSString *)text {
    
    NSMutableDictionary * pairs = [[NSMutableDictionary alloc] init];
    NSString * word;
    
    @autoreleasepool {
        for (word in words)
            if ([TranspositionCrack hasSameChars:text and:word])
                [pairs setObject:[text copy] forKey:[word copy]];
    }
    return pairs;
}


+ (NSArray *)getAllWordsOfLengths:(NSArray *)lengths {
    
    NSArray * words = [Utils makeArraysArrayWith:[lengths count]];
    FileReader * reader = [TranspositionCrack getDictionaryFileReader];
    
    NSString * line = nil;
    while ((line = [reader readLine])) {
        line = [Utils removeWhiteEnd:line];
        
        for (int i = 0; i < [lengths count]; i++)
            if ([line length] == [lengths[i] intValue])
                [words[i] addObject:line];
    }
    return words;
}

+ (NSArray *)getAllWordsOfLength:(int)length {
    
    NSMutableArray * words = [[NSMutableArray alloc] init];
    NSString * lang = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    NSString * fileName = [NSString stringWithFormat:@"%@_dictionary", lang];
    NSString * path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    FileReader * reader = [[FileReader alloc] initWithFilePath:path];
    
    NSString * line = nil;
    while ((line = [reader readLine])) {
        line = [Utils removeWhiteEnd:line];
        
        if ([line length] == length)
            [words addObject:line];
    }
    return words;
}

+ (FileReader *)getDictionaryFileReader {
    
    NSString * lang = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    NSString * fileName = [NSString stringWithFormat:@"%@_dictionary", lang];
    NSString * path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    
    return [[FileReader alloc] initWithFilePath:path];
}


+ (bool)hasSameChars:(NSString *)string1 and:(NSString *)string2 {
    
    if ([string1 length] != [string2 length]) return false;
    
    return [[[Utils makeCharArrayFrom:string1] sortedArrayUsingSelector:@selector(compare:)]
            isEqualToArray:
            [[Utils makeCharArrayFrom:string2] sortedArrayUsingSelector:@selector(compare:)]];
}



@end
