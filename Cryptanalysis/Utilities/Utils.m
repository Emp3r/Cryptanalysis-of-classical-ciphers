#import "Utils.h"
#import "Language.h"
#import "LanguageParser.h"

@implementation Utils


+ (NSArray *)availableCiphers {
    return @[@"Caesar", @"Vigenère", @"Monoalphabetic", @"Transposition"];
}

+ (NSArray *)availableCiphersNormalized {
    // for file names etc.
    return @[@"Caesar", @"Vigenere", @"Monoalphabetic", @"Transposition"];
}

+ (NSArray *)availableAttacks {
    return @[@[@"Brute force - frequency", @"Brute force - real words", @"Triangle attack"],
             @[@"Guessed key length attack", @"Modified triangle attack"],
             @[@"Unique words attack"],
             @[@"Finding word attack", @"Brute force - real words"]];
}

+ (NSArray *)availableAttacksFor:(int)cipherIndex {
    return [Utils availableAttacks][cipherIndex];
}


+ (NSString *)normalize:(NSString *)string; {
    
    string = [string lowercaseString];
    NSMutableString *result = [NSMutableString string];
    
    for (int i = 0; i < [string length]; i++) {
        char letter = [string characterAtIndex:i];
        
        if (letter >= 'a' && letter <= 'z')
            [result appendFormat:@"%c", letter];
    }
    return result;
}

+ (bool)isAllowedSymbol:(char)symbol {
    
    return ((symbol >= '0' && symbol <= '9') || symbol == ' ' || symbol == '.' || symbol == ',');
}


+ (NSArray *)lettersCount:(NSString *)string {
    
    string = [string lowercaseString];
    NSMutableArray * result = [[Utils makeNumberArrayWith:LETTER_COUNT] mutableCopy];
    
    for (int i = 0; i < [string length]; i++) {
        char letter = [string characterAtIndex:i];
        
        if (letter >= 'a' && letter <= 'z') {
            char index = letter - 'a';
            result[index] = @([result[index] intValue] + 1);
        }
    }
    return result;
}

+ (NSArray *)lettersFrequency:(NSString *)string {
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    NSArray * counts = [Utils lettersCount:string];
    int length = (int)[[Utils normalize:string] length];
    
    for (NSNumber * number in counts) {
        float letterPercent = ([number floatValue] / length) * 100;
        [result addObject:[NSNumber numberWithFloat:letterPercent]];
    }
    
    return result;
}

+ (NSDictionary *)frequencyDictionary:(NSArray *)frequency {
    
    NSMutableDictionary * result = [[NSMutableDictionary alloc] init];
    
    for (char i = 0; i < LETTER_COUNT; i++) {
        [result setObject:frequency[i]
                   forKey:[NSString stringWithFormat:@"%c", 'a' + i]];
    }
    
    return result;
}


+ (float)frequencyDifference:(NSArray *)frequencies {
    
    float difference = 0.0;
    
    for (char i = 0; i < LETTER_COUNT; i++) {
        float expected = [Language.expectedFrequency[i] floatValue];
        difference += fabsf([frequencies[i] floatValue] - expected);
    }
    
    return difference;
}



+ (int)realWordsCount:(NSString *)string {
    
    int result = 0;
    NSError *error = nil;

    for (NSString *word in Language.mostUsedWords) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:word options:NSRegularExpressionCaseInsensitive error:&error];
        
        result += [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
    }
    return result;
}

+ (char)getRandomLetter {
    return (char)(arc4random_uniform(26) + 'a');
}

+ (NSString *)removeDuplicates:(NSString *)text {
    
    NSMutableString * result = [NSMutableString string];
    NSMutableSet * seenCharacters = [NSMutableSet set];
    
    [text enumerateSubstringsInRange:NSMakeRange(0, text.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (![seenCharacters containsObject:substring]) {
            [seenCharacters addObject:substring];
            [result appendString:substring];
        }
    }];
    return result;
}


+ (NSString *)getCanonicalForm:(NSString *)word {
    
    word = [Utils normalize: word];
    NSMutableString * result = [NSMutableString string];
    int counter = 10;
    int substitutions[LETTER_COUNT];
    for (char i = 0; i < LETTER_COUNT; i++) substitutions[i] = 0;
    
    for (int i = 0; i < [word length]; i++) {
        char c = [word characterAtIndex: i];
        char pos = c - 'a';
        
        if (substitutions[pos] == 0) {
            substitutions[pos] = counter;
            counter++;
        }
        [result appendString:[NSString stringWithFormat:@"%i", substitutions[pos]]];
    }
    return result;
}

+ (NSArray *)makeNumberArrayWith:(int)elements {
    
    NSMutableArray * result = [NSMutableArray array];
    
    for (int i = 0; i < elements; i++)
        [result addObject:[NSNumber numberWithInt:0]];
    
    return result;
}


+ (NSArray *)makeCharArrayFrom:(NSString *)string {
    
    NSMutableArray *letterArray = [NSMutableArray array];
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                                options:(NSStringEnumerationByComposedCharacterSequences)
                             usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                 [letterArray addObject:substring];
                             }];
    return letterArray;
}


+ (NSArray *)sortNestedArray:(NSArray *)array {
    
    NSMutableArray * mutableArray = [array mutableCopy];
    
    for (int i = 0; i < [mutableArray count]; i++)
        mutableArray[i] = [mutableArray[i] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    return mutableArray;
}


+ (NSArray *)getAllDivisors:(int)number {
    
    NSMutableArray * results = [[NSMutableArray alloc] init];
    int i = 2;
    
    while (i <= sqrt(number)) {
        if (number % i == 0) {
            [results addObject:[NSNumber numberWithInt:i]];
            
            if (i != (number / i)) {
                [results addObject:[NSNumber numberWithInt:(number / i)]];
            }
        }
        i++;
    }
    return results;
}

+ (NSArray *)getAllDivisors:(int)number max:(int)maxNumber {
    
    NSArray * allDivisors = [Utils getAllDivisors:number];
    NSPredicate * predicate = [NSPredicate predicateWithFormat: @"SELF <= %d", maxNumber];
    
    return [allDivisors filteredArrayUsingPredicate: predicate];
}




@end
