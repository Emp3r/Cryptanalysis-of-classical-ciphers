#import "TranspositionCrack.h"
#import "Transposition.h"
#import "Utils.h"
#import "Language.h"
#import "Storage.h"
#import "Combinatorics.h"
#import "FileReader.h"

@implementation TranspositionCrack


// brute force - real words count
+ (NSString *)realWordsAnalysisKeyGuess:(NSString *)text {

    text = [Utils normalize:text];
    NSArray * keys = [TranspositionCrack getAllKeysForText:text maxLength:7];
    NSString * bestGuess = [TranspositionCrack findMostProbableKey:text
                                                          fromKeys:keys];
    
    return bestGuess;
}

+ (NSString *)findMostProbableKey:(NSString *)text fromKeys:(NSArray *)keys {
    
    NSString * bestGuess = @"a";
    int bestValue = 0;
    
    for (NSString * key in keys) {
        @autoreleasepool {
            NSString * decrypted = [Transposition decrypt:text with:key];
            int realWordsCount = [Utils realWordsCount:decrypted];
            
            if (realWordsCount > bestValue) {
                bestValue = realWordsCount;
                bestGuess = key;
            }
        }
    }
    return bestGuess;
}

+ (NSArray *)getAllKeysForText:(NSString *)text maxLength:(int)maxLength {
    
    int length = (int)[text length];
    NSArray * divisors = [Utils getDivisors:length max:maxLength];
    
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
    NSArray * keyLengths = [Utils getDivisors:[text length] min:4 max:12];
    NSMutableDictionary * pairs = [[NSMutableDictionary alloc] init];
    
    for (NSNumber * keyLength in keyLengths) {
        @autoreleasepool {
            int columns = ceil((float)[text length] / [keyLength intValue]);
            NSArray * textColumns = [Transposition getTextParts:text length:columns];
            NSArray * textRows = [Transposition readColumnsFrom:textColumns length:columns];
            NSArray * words = [TranspositionCrack getAllWordsOfLength:[keyLength intValue]];
            
            for (NSString * row in textRows) {
                @autoreleasepool {
                    for (NSString * word in words)
                        if ([TranspositionCrack hasSameChars:row and:word])
                            [pairs setObject:row forKey:word];
                }
            }
        }
    }
    NSArray * keys = [TranspositionCrack makeKeysFromPairs:pairs];
    
    return [TranspositionCrack findMostProbableKey:text fromKeys:keys];
}

+ (NSArray *)makeKeysFromPairs:(NSDictionary *)pairs {
    
    NSMutableArray * keys = [[NSMutableArray alloc] init];
    NSArray * letterOrders = [TranspositionCrack makeLetterOrdersFromPairs:pairs];
    letterOrders = [[NSOrderedSet orderedSetWithArray:letterOrders] array];
    
    for (NSArray * o in letterOrders) {
        NSMutableArray * key = [[NSMutableArray alloc] init];
        
        for (NSNumber * n in o)
            [key addObject:[NSString stringWithFormat:@"%c", ('a' + [n intValue])]];
    
        [keys addObject:[key componentsJoinedByString:@""]];
    }
    return keys;
}

+ (NSArray *)makeLetterOrdersFromPairs:(NSDictionary *)pairs {
    
    NSMutableArray * letterOrders = [[NSMutableArray alloc] init];
    
    for (NSString * key in [pairs allKeys]) {
        NSDictionary * positions = [TranspositionCrack getLettersPositions:key];
        NSMutableArray * perms = [[NSMutableArray alloc] init];
        
        [TranspositionCrack getPermutations:key current:0 positions:positions
                                    visited:[NSArray array] result:&perms];
        
        [letterOrders addObjectsFromArray:perms];
    }
    return letterOrders;
}

+ (NSDictionary *)getLettersPositions:(NSString *)string {
    
    NSMutableDictionary * result = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < [string length]; i++) {
        NSString * letter = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        
        if ([result objectForKey:letter]) {
            [result[letter] addObject:[NSNumber numberWithInt:i]];
        } else {
            result[letter] = [NSMutableArray arrayWithObject:[NSNumber numberWithInt:i]];
        }
    }
    return result;
}

+ (void)getPermutations:(NSString *)word current:(int)current positions:(NSDictionary *)positions visited:(NSArray *)visited result:(NSMutableArray **)result {

    if (current == [word length]) {
        [*result addObject:visited];
    }
    else {
        NSString * key = [NSString stringWithFormat:@"%c", [word characterAtIndex:current]];
        
        if ([positions objectForKey:key]) {
            for (NSNumber * i in positions[key]) {
                if (![visited containsObject:i]) {
                    NSMutableArray * next = [NSMutableArray arrayWithArray:visited];
                    [next addObject:i];
                    [TranspositionCrack getPermutations:word current:(current + 1)
                                              positions:positions visited:next result:result];
                }
            }
        }
        else {
            [*result removeAllObjects];
        }
    }
}


+ (NSArray *)getAllWordsOfLength:(int)length {
    
    NSMutableArray * words = [[NSMutableArray alloc] init];
    FileReader * reader = [Storage dictionaryFileReader];
    
    NSString * line = nil;
    while ((line = [reader readLine])) {
        line = [Utils removeWhiteEnd:line];
        
        if ([line length] == length)
            [words addObject:line];
    }
    
    if ([words count] == 0)
        words = [[[Language mostUsedWords] filteredArrayUsingPredicate:
                  [NSPredicate predicateWithFormat:@"length == %@", length]] mutableCopy];
    
    return words;
}


+ (bool)hasSameChars:(NSString *)string1 and:(NSString *)string2 {
    
    if ([string1 length] != [string2 length]) return false;
    
    return [[[Utils makeCharArrayFrom:string1] sortedArrayUsingSelector:@selector(compare:)]
            isEqualToArray:
            [[Utils makeCharArrayFrom:string2] sortedArrayUsingSelector:@selector(compare:)]];
}


@end
