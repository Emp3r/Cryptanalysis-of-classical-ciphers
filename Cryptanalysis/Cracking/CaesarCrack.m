#import "CaesarCrack.h"
#import "Caesar.h"
#import "Utils.h"
#import "Combinatorics.h"
#import "Language.h"

@implementation CaesarCrack

// frequency analysis
+ (char)guessKeyLetterFrequency:(NSString *)text {
    
    char bestGuess = 'a';
    float smallestDifference = FLT_MAX;
    
    for (char i = 0; i < LETTER_COUNT; i++) {
        
        NSString * actualString = [Caesar decrypt:text withChar:'a' + i];
        NSArray * frequency = [Utils lettersFrequency:actualString];
        float difference = [Utils frequencyDifference:frequency];
        
        if (difference < smallestDifference) {
            smallestDifference = difference;
            bestGuess = 'a' + i;
        }
    }
    return bestGuess;
}

+ (NSString *)frequencyAnalysisKeyGuess:(NSString *)text {
    
    NSString * normalizedString = [Utils normalize:text];
    char keyGuess = [CaesarCrack guessKeyLetterFrequency:normalizedString];
    
    return [NSString stringWithFormat:@"%c", keyGuess];
}

+ (NSString *)breakWithLetterFrequency:(NSString *)text {
    
    NSString * normalizedString = [Utils normalize:text];
    char keyGuess = [CaesarCrack guessKeyLetterFrequency:normalizedString];
    
    return [Caesar decrypt:text withChar:keyGuess];
}



// real words analysis
+ (char)guessKeyRealWords:(NSString *)text {
    
    char bestGuess = 'a';
    int bestValue = 0;
    
    for (char i = 0; i < LETTER_COUNT; i++) {
        
        NSString * decrypted = [Caesar decrypt:text withChar:'a' + i];
        int realWordsCount = [Utils realWordsCount:decrypted];
        
        if (realWordsCount > bestValue) {
            bestValue = realWordsCount;
            bestGuess = 'a' + i;
        }
    }
    return bestGuess;
}

+ (NSString *)realWordsAnalysisKeyGuess:(NSString *)text {
    
    NSString * normalizedString = [Utils normalize:text];
    char keyGuess = [CaesarCrack guessKeyRealWords:normalizedString];
    
    return [NSString stringWithFormat:@"%c", keyGuess];
}

+ (NSString *)breakWithRealWords:(NSString *)text {
    
    char keyGuess = [CaesarCrack guessKeyRealWords:text];
    
    return [Caesar decrypt:text withChar:keyGuess];
}



// frequent letters distance attack
+ (NSString *)lettersDistanceKeyGuess:(NSString *)text {
    
    int k = 3, n = 7;
    
    NSArray * mostUsedCharsInLang = [[CaesarCrack mostUsedChars:Language.expectedFrequency size:k] allKeys];
    NSArray * mostUsedCharsInText = [[CaesarCrack mostUsedChars:[Utils lettersFrequency:text] size:n] allKeys];
    NSArray * mostUsedAllCombinations = [CaesarCrack getCharCombinations:mostUsedCharsInText chose:k from:n];
    
    mostUsedCharsInLang = [mostUsedCharsInLang sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    mostUsedAllCombinations = [Utils sortNestedArray:mostUsedAllCombinations];
    
    NSArray * found = [CaesarCrack findSameDistanceCombination:mostUsedCharsInLang in:mostUsedAllCombinations];
    
    if ([found count] > 0) {
        char letter = 'a' + abs([found[0] characterAtIndex:0] - [mostUsedCharsInLang[0] characterAtIndex:0]);
        return [NSString stringWithFormat:@"%c", letter];
    } else {
        return @"a";
    }
}


+ (NSArray *)findSameDistanceCombination:(NSArray *)chars in:(NSArray *)combinations {
    
    NSArray * result = [[NSMutableArray alloc] init];
    
    for (NSArray * row in combinations) {
        if ([CaesarCrack hasSameMinimalDistance:chars and:row]) {
            result = row;
        }
        else {
            NSArray * permutations = [Combinatorics getPermutationArrays:row];
            
            for (NSArray * p in permutations)
                if ([CaesarCrack hasSameMinimalDistance:chars and:p])
                    result = p;
        }
    }
    return result;
}

+ (bool)hasSameMinimalDistance:(NSArray *)array1 and:(NSArray *)array2 {
    
    int count = (int)MIN([array1 count], [array2 count]);
    bool found = true;
    
    for (int i = 0; i < count; i++) {
        for (int j = 0; j < count; j++) {
            int mdl = [CaesarCrack minimalDistanceOfFirstChars:array1[i] and:array1[j]];
            int mdc = [CaesarCrack minimalDistanceOfFirstChars:array2[i] and:array2[j]];
            
            if (mdl != mdc) found = false;
        }
    }
    return found;
}


+ (NSArray *)getCharCombinations:(NSArray *)chars chose:(int)k from:(int)n {
    
    if ([chars count] < n) return [NSArray array];
    
    NSArray * combinations = [Combinatorics getCombinationArrays:k from:n];
    
    return [CaesarCrack mapCharsToCombinations:chars indexes:combinations];
}

+ (NSArray *)mapCharsToCombinations:(NSArray *)chars indexes:(NSArray *)indexes {
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    
    for (NSArray * row in indexes) {
        NSMutableArray * newRow = [[NSMutableArray alloc] init];
        
        for (NSNumber * n in row) {
            [newRow addObject:chars[[n intValue]]];
        }
        [result addObject:newRow];
    }
    
    return result;
}


+ (NSDictionary *)mostUsedChars:(NSArray *)frequency size:(int)size {
    
    NSMutableDictionary * result = [[NSMutableDictionary alloc] init];
    NSMutableArray * frequencyArray = [frequency mutableCopy];
    
    for (int i = 0; i < size; i++) {
        int characterIndex = 0;
        
        for (int j = 0; j < LETTER_COUNT; j++) {
            float value = [frequencyArray[j] floatValue];
            
            if ([frequencyArray[characterIndex] floatValue] < value)
                characterIndex = j;
        }
        [result setObject:frequency[characterIndex]
                   forKey:[NSString stringWithFormat:@"%c", 'a' + characterIndex]];
        [frequencyArray replaceObjectAtIndex:characterIndex withObject:@(FLT_MIN)];
    }
    return result;
}

+ (NSDictionary *)leastUsedChars:(NSArray *)frequency size:(int)size {
    
    NSMutableDictionary * result = [[NSMutableDictionary alloc] init];
    NSMutableArray * frequencyArray = [frequency mutableCopy];
    
    for (int i = 0; i < size; i++) {
        int characterIndex = 0;
        
        for (int j = 0; j < LETTER_COUNT; j++) {
            float value = [frequencyArray[j] floatValue];
            
            if ([frequencyArray[characterIndex] floatValue] > value)
                characterIndex = j;
        }
        [result setObject:frequency[characterIndex]
                   forKey:[NSString stringWithFormat:@"%c", 'a' + characterIndex]];
        [frequencyArray replaceObjectAtIndex:characterIndex withObject:@(FLT_MAX)];
    }
    return result;
}

+ (int)minimalDistanceOfFirstChars:(NSString *)firstString and:(NSString *)secondString {

    char first = [firstString characterAtIndex:0];
    char second = [secondString characterAtIndex:0];
    
    return [CaesarCrack minimalDistance:first and:second];
}

+ (int)minimalDistance:(char)firstChar and:(char)secondChar {
    
    int distance = abs(firstChar - secondChar);
    
    return MIN(distance, LETTER_COUNT - distance);
}


@end
