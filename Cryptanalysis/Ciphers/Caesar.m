#import "Caesar.h"
#import "Utils.h"
#import "Language.h"

@implementation Caesar


+ (NSString *)encrypt:(NSString *)text withKey:(NSString *)key {
    if ([key length] > 0)
        return [Caesar encrypt:text withChar:[key characterAtIndex:0]];
    else
        return text;
}

+ (NSString *)decrypt:(NSString *)text withKey:(NSString *)key {
    if ([key length] > 0)
        return [Caesar decrypt:text withChar:[key characterAtIndex:0]];
    else
        return text;
}


+ (NSString *)encrypt:(NSString *)text withChar:(char)key {
    
    text = [text lowercaseString];
    NSMutableString * result = [NSMutableString string];
    char encryptedLetter;
    char shift = key - 'a';
    
    for (int i = 0; i < [text length]; i++) {
        encryptedLetter = [Caesar shiftRight:[text characterAtIndex:i] with:shift];
        [result appendFormat:@"%c", encryptedLetter];
    }
    return [result uppercaseString];
}

+ (NSString *)decrypt:(NSString *)text withChar:(char)key {
    
    text = [text lowercaseString];
    NSMutableString * result = [NSMutableString string];
    char decryptedLetter;
    char shift = key - 'a';
    
    for (int i = 0; i < [text length]; i++) {
        decryptedLetter = [Caesar shiftLeft:[text characterAtIndex:i] with:shift];
        [result appendFormat:@"%c", decryptedLetter];
    }
    return result;
}


+ (char)shiftRight:(char)symbol with:(char)shift {
    
    char encryptedSymbol = '\0';
    
    if (symbol >= 'a' && symbol <= 'z') {
        encryptedSymbol = symbol + shift;
        
        if (encryptedSymbol > 'z' || encryptedSymbol < 'a')
            encryptedSymbol -= LETTER_COUNT;
    }
    else if ([Utils isAllowedSymbol:symbol]) {
        encryptedSymbol = symbol;
    }
    return encryptedSymbol;
}

+ (char)shiftLeft:(char)symbol with:(char)shift {
    
    char encryptedSymbol = '\0';
    
    if (symbol >= 'a' && symbol <= 'z') {
        encryptedSymbol = symbol - shift;
        
        if (encryptedSymbol > 'z' || encryptedSymbol < 'a')
            encryptedSymbol += LETTER_COUNT;
    }
    else if ([Utils isAllowedSymbol:symbol]) {
        encryptedSymbol = symbol;
    }
    return encryptedSymbol;
    
}


+ (bool)isAllowedKey:(NSString *)key {
    return ([key length] == 1 &&
            [key characterAtIndex:0] >= 'a' &&
            [key characterAtIndex:0] <= 'z');
}

+ (NSString *)generateRandomKey {
    return [NSString stringWithFormat:@"%c", [Utils getRandomLetter]];
}


@end
