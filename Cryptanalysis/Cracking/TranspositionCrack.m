#import "TranspositionCrack.h"
#import "Transposition.h"
#import "Utils.h"
#import "Combinatorics.h"

@implementation TranspositionCrack


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
    NSArray * divisors = [Utils getAllDivisors:length max:7];
    
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



@end
