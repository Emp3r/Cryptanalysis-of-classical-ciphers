#import "Monoalphabetic.h"
#import "Utils.h"
#import "Language.h"

@implementation Monoalphabetic


+ (NSString *)encrypt:(NSString *)text withKey:(NSString *)key {
    
    text = [text lowercaseString];
    key = [key lowercaseString];
    NSMutableString * result = [NSMutableString string];
    char shifts[LETTER_COUNT];
    
    for (char i = 0; i < LETTER_COUNT; i++)
        shifts[i] = [key characterAtIndex:i];
    
    for (int i = 0; i < [text length]; i++) {
        char letter = [text characterAtIndex:i];
        
        if (letter >= 'a' && letter <= 'z') {
            [result appendFormat:@"%c", shifts[letter - 'a']];
        }
        else if ([Utils isAllowedSymbol:letter]) {
            [result appendFormat:@"%c", letter];
        }
    }
    return [result uppercaseString];
}

+ (NSString *)decrypt:(NSString *)text withKey:(NSString *)key {
    
    text = [text lowercaseString];
    key = [key lowercaseString];
    NSMutableString * result = [NSMutableString string];
    char shifts[LETTER_COUNT];
    
    for (char i = 0; i < LETTER_COUNT; i++) shifts[i] = '*';
    
    for (char i = 0; i < LETTER_COUNT; i++) {
        char keyLetter = [key characterAtIndex:i];
        
        if (keyLetter >= 'a' && keyLetter <= 'z')
            shifts[keyLetter - 'a'] = i + 'a';
    }
    
    for (int i = 0; i < [text length]; i++) {
        char letter = [text characterAtIndex:i];
        
        if (letter >= 'a' && letter <= 'z') {
            [result appendFormat:@"%c", shifts[letter - 'a']];
        }
        else if ([Utils isAllowedSymbol:letter]) {
            [result appendFormat:@"%c", letter];
        }
    }
    return result;
}


+ (NSString *)fixKey:(NSString *)key {
    
    key = [Utils removeDuplicates:[Utils normalize:key]];
    
    if ([key length] < LETTER_COUNT) {
        return [Monoalphabetic fillToAllowedKey:key];
    }
    else if ([key length] > LETTER_COUNT) {
        return [key substringToIndex:LETTER_COUNT];
    }
    else {
        return key;
    }
}

+ (NSString *)fillToAllowedKey:(NSString *)key {
    
    key = [Utils removeDuplicates:key];
    NSMutableString * result = [NSMutableString stringWithString:key];
    
    // fill key with random chars to have the right length (LETTER_COUNT = 26)
    for (char i = 0; i < LETTER_COUNT - [key length]; i++) {
        [result appendString:@"*"];
    }
    
    for (char i = 'a'; i <= 'z'; i++) {
        NSRange found = [result rangeOfString:[NSString stringWithFormat:@"%c", i]];
    
        if (found.location != NSNotFound) continue;
        
        while (true) {
            char index = arc4random_uniform(LETTER_COUNT);
            
            if ([result characterAtIndex:index] == '*') {
                [result replaceCharactersInRange:NSMakeRange(index, 1)
                                      withString:[NSString stringWithFormat:@"%c", i]];
                break;
            }
        }
    }
    return result;
}


+ (bool)isAllowedKey:(NSString *)key {
    
    key = [Utils removeDuplicates:key];
    
    NSString * patter = [NSString stringWithFormat:@"^[a-zA-Z]{%d}$", LETTER_COUNT];
    
    return [key rangeOfString:patter options:NSRegularExpressionSearch].location != NSNotFound;
}

+ (NSString *)generateRandomKey {
    
    return [Monoalphabetic fillToAllowedKey:@""];
}


@end
