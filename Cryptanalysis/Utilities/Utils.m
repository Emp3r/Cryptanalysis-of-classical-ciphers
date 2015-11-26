#import "Utils.h"
#import "Language.h"
#import "LanguageParser.h"

@implementation Utils


+ (NSString *)normalize:(NSString *)string; {
    /*
    string = [string lowercaseString];
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < [string length]; i++) {
        char letter = [string characterAtIndex:i];
        if (letter >= 'a' && letter <= 'z') [result appendFormat:@"%c", letter];
    }
    return result;
     */
    return [Utils normalize:string removeMatches:@"[^a-zA-Z]"];
}

+ (NSString *)normalizeLeaveSpaces:(NSString *)string {
    return [Utils normalize:string removeMatches:@"[^a-zA-Z\\s]"];
}

+ (NSString *)normalize:(NSString *)string removeMatches:(NSString *)regex {
    string = [string lowercaseString];
    return [string stringByReplacingOccurrencesOfString: regex
                                             withString: @""
                                                options: NSRegularExpressionSearch
                                                  range: NSMakeRange(0, [string length])];
}

+ (NSString *)removeWhiteEnd:(NSString *)string {
    
    char lastChar = [string characterAtIndex:[string length] - 1];
    
    if (lastChar == ' ' || lastChar == '\n')
        return [Utils removeWhiteEnd:[string substringToIndex:[string length] - 1]];
    else
        return string;
}

+ (bool)isAllowedSymbol:(char)symbol {
    return ((symbol >= '0' && symbol <= '9') || symbol == ' ' || symbol == '.' || symbol == ',');
}

+ (NSString *)rewriteTextToASCIIChars:(NSString *)text {
    return [[NSString alloc] initWithData:[text dataUsingEncoding:NSASCIIStringEncoding
                                             allowLossyConversion:YES]
                                 encoding:NSASCIIStringEncoding];
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

+ (NSArray *)makeArraysArrayWith:(int)elements {
    
    NSMutableArray * result = [NSMutableArray array];
    
    for (int i = 0; i < elements; i++)
        [result addObject:[[NSMutableArray alloc] init]];
    
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

+ (NSArray *)getDivisors:(int)number min:(int)min {
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF >= %d", min];
    
    return [[Utils getAllDivisors:number] filteredArrayUsingPredicate:predicate];
}

+ (NSArray *)getDivisors:(int)number max:(int)max {
   
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF <= %d", max];
    
    return [[Utils getAllDivisors:number] filteredArrayUsingPredicate:predicate];
}


+ (NSArray *)getDivisors:(int)number min:(int)min max:(int)max {
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF <= %d", max];
    
    return [[Utils getDivisors:number min:min] filteredArrayUsingPredicate:predicate];
}


@end
