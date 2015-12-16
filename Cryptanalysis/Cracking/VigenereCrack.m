#import "VigenereCrack.h"
#import "Vigenere.h"
#import "CaesarCrack.h"
#import "Utils.h"

@implementation VigenereCrack

// key length
+ (int)guessKeyLength:(NSString *)text {
    
    int result = 1;
    
    NSArray * divisors = [VigenereCrack findDistanceDivisors:text];
    int bestMatch = 0;
    
    for (int i = [divisors count] - 1; i > 1; i--) {
        int actualValue = [[divisors objectAtIndex:i] intValue];
        
        if (bestMatch < actualValue) {
            bestMatch = actualValue;
            result = i + 2;
        }
    }
    
    return result;
}

+ (NSArray *)codedTextSplitted:(NSString *)text {
    
    text = [Utils normalize:text];
    NSMutableArray * result = [[NSMutableArray alloc] init];
    int keyLength = [VigenereCrack guessKeyLength:text];
    
    for (int i = 0; i < keyLength; i++) {
        @autoreleasepool {
            NSMutableString * splittedText = [[NSMutableString alloc] init];
            
            for (int j = i; j < [text length]; j += keyLength)
                [splittedText appendFormat:@"%c", [text characterAtIndex:j]];
            
            [result addObject:splittedText];
        }
    }
    return result;
}

+ (NSArray *)findDistanceDivisors:(NSString *)text {
    
    text = [Utils normalize:text];
    NSMutableArray * result = [[Utils makeNumberArrayWith:19] mutableCopy];
    
    for (int i = 0; i < [text length] - 8; i++) {
        @autoreleasepool {
            NSString * actualString = [text substringFromIndex:i];
            
            for (char j = 7; j >= 4; j--) {
                NSString * restOfText = [actualString substringFromIndex:j];
                NSRange range = [restOfText rangeOfString:[actualString substringToIndex:j]];
                
                if (range.location != NSNotFound) {
                    int distance = (int)range.location + j;
                    
                    for (char k = 2; k <= 20; k++) {
                        if (distance % k == 0) {
                            int nextValue = [[result objectAtIndex:k - 2] intValue] + 1;
                            
                            [result replaceObjectAtIndex:k - 2
                                              withObject:@(nextValue)];
                        }
                    }
                    i = i + j;
                    break;
                }
            }
        }
    }
    return result;
}



// frequency analysis
+ (NSString *)frequencyAnalysisKeyGuess:(NSString *)text {
    
    NSArray * parts = [VigenereCrack codedTextSplitted:text];
    NSMutableString * result = [[NSMutableString alloc] init];
    
    for (NSString * part in parts) {
        char actualKey = [CaesarCrack guessKeyLetterFrequency:part];
        
        [result appendFormat:@"%c", actualKey];
    }
    return result;
}

+ (NSString *)breakWithLetterFrequency:(NSString *)text {
    
    NSString * keyGuess = [VigenereCrack frequencyAnalysisKeyGuess:text];
    
    return [Vigenere decrypt:text withKey:keyGuess];
}



// frequent letters minimal distance attack
+ (NSString *)lettersDistanceKeyGuess:(NSString *)text {
    
    NSArray * parts = [VigenereCrack codedTextSplitted:text];
    NSMutableString * result = [[NSMutableString alloc] init];
    
    for (NSString * part in parts) {
        NSString * actualKey = [CaesarCrack lettersDistanceKeyGuess:part];
        
        [result appendString:actualKey];
    }
    return result;
}



+ (NSString *)keyGuess:(NSString *)text {
    return [VigenereCrack frequencyAnalysisKeyGuess:text];
}

+ (NSString *)breakCodedText:(NSString *)text {
    return [Vigenere decrypt:text
                     withKey:[VigenereCrack keyGuess:text]];
}

+ (bool)isGuessedKey:(NSString *)guess equalToKey:(NSString *)key {
    
    if ([key length] != [guess length])
        return false;
    
    int allowedDifference = ([key length] >= 7) ? 2 : 1;
    
    for (int i = 0; i < [key length]; i++)
        if ([key characterAtIndex:i] != [guess characterAtIndex:i])
            allowedDifference--;
    
    return allowedDifference >= 0;
}


@end
