#import "Vigenere.h"
#import "Caesar.h"
#import "Utils.h"

@implementation Vigenere


+ (NSString *)encrypt:(NSString *)text with:(NSString *)key {
    
    text = [text lowercaseString];
    key = [Utils normalize:[key lowercaseString]];
    NSMutableString * result = [NSMutableString string];
    char letter, encryptedLetter, shift;
    
    for (int i = 0, keyIndex = 0; i < [text length]; i++) {
        letter = [text characterAtIndex:i];
        shift = [key characterAtIndex:(keyIndex % [key length])] - 'a';
        
        encryptedLetter = [Caesar shiftRight:letter with:shift];
        [result appendFormat:@"%c", encryptedLetter];

        if (letter >= 'a' && letter <= 'z') keyIndex++;
    }
    return [result uppercaseString];
}

+ (NSString *)decrypt:(NSString *)text with:(NSString *)key {
    
    text = [text lowercaseString];
    key = [Utils normalize:[key lowercaseString]];
    NSMutableString * result = [NSMutableString string];
    char letter, decryptedLetter, shift;
    
    for (int i = 0, keyIndex = 0; i < [text length]; i++) {
        letter = [text characterAtIndex:i];
        shift = [key characterAtIndex:(keyIndex % [key length])] - 'a';
        
        decryptedLetter = [Caesar shiftLeft:letter with:shift];
        [result appendFormat:@"%c", decryptedLetter];
        
        if (letter >= 'a' && letter <= 'z') keyIndex++;
    }
    return result;
}


+ (bool)isAllowedKey:(NSString *)key {
    
    NSString * pattern = [NSString stringWithFormat:@"^[a-zA-Z ]{%i}$", (int)[key length]];
    
    return [key rangeOfString:pattern options:NSRegularExpressionSearch].location != NSNotFound;
}

+ (NSString *)generateRandomKey {
    // generate random string between 4 to 7 chars
    char keyLength = 4 + arc4random_uniform(4);
    NSMutableString * result = [NSMutableString string];
    
    for (char i = 0; i < keyLength; i++)
        [result appendFormat:@"%c", [Utils getRandomLetter]];
    
    return result;
}


@end
