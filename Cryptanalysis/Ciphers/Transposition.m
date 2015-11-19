#import "Transposition.h"
#import "Utils.h"
#import "Language.h"

@implementation Transposition


+ (NSString *)encrypt:(NSString *)text with:(NSString *)key {
    
    text = [Utils normalize:text];
    key = [Utils normalize:key];
    short keyLength = [key length];
    
    NSArray * keyOrder = [Transposition makeKeyOrder:key];
    NSArray * parts = [Transposition getTextParts:text with:keyLength];
    NSArray * partsScrambled = [Transposition getScrambledParts:parts with:keyOrder];
    NSArray * columns = [Transposition readColumnsFrom:partsScrambled with:keyLength];
    
    return [[columns componentsJoinedByString:@" "] uppercaseString];
}

+ (NSString *)decrypt:(NSString *)text with:(NSString *)key {
    
    text = [Utils normalize:text];
    key = [Utils normalize:key];
    short keyLength = [key length];
    int columns = ceil((float)[text length] / keyLength);
    
    NSArray * reverseKeyOrder = [Transposition makeReverseKeyOrder:key];
    NSArray * parts = [Transposition getTextParts:text with:columns];
    NSArray * preparedParts = [Transposition readColumnsFrom:parts with:columns];
    NSArray * decryptedParts = [Transposition getScrambledParts:preparedParts with:reverseKeyOrder];
    
    return [decryptedParts componentsJoinedByString:@""];
}


+ (NSArray *)makeKeyOrder:(NSString *)key {
    
    NSMutableArray * keyOrder = [NSMutableArray array];
    NSMutableDictionary * keyValues = [NSMutableDictionary dictionary];
    
    for (short i = 0; i < [key length]; i++)
        keyValues[[NSString stringWithFormat:@"%c", [key characterAtIndex:i]]] = [NSNumber numberWithInt:i];
    
    for (char c = 'a'; c <= 'z'; c++) {
        NSNumber * n = [keyValues objectForKey:[NSString stringWithFormat:@"%c", c]];
        if (n)
            [keyOrder addObject:n];
    }
    return keyOrder;
}

+ (NSArray *)makeReverseKeyOrder:(NSString *)key {
    
    NSMutableArray * reverseKeyOrder = [NSMutableArray array];
    NSArray * keyOrder = [Transposition makeKeyOrder:key];
    
    for (short i = 0; i < [key length]; i++) {
        NSNumber * n = [NSNumber numberWithInteger:[keyOrder indexOfObject:[NSNumber numberWithInt:i]]];
        [reverseKeyOrder addObject:n];
    }
    return reverseKeyOrder;
}


+ (NSArray *)getTextParts:(NSString *)text with:(short)partLength {
    
    NSMutableString * workText = [NSMutableString stringWithString:text];
    NSMutableArray * partsUnchanged = [[NSMutableArray alloc] init];
    short textLength = [text length];
    short rows = ceil((float)textLength / partLength);
    
    if (rows * partLength > textLength)
        for (short i = 0; i < (rows * partLength - textLength); i++)
            [workText appendFormat:@"%c", [Utils getRandomLetter]];
    
    for (short i = 0; i < rows; i++) {
        [partsUnchanged addObject:[workText substringToIndex:partLength]];
        workText = [NSMutableString stringWithString:[workText substringFromIndex:partLength]];
    }
    return partsUnchanged;
}

+ (NSArray *)getScrambledParts:(NSArray *)parts with:(NSArray *)keyOrder {
    
    NSMutableArray * partsChanged = [NSMutableArray array];
    
    for (NSString * part in parts) {
        NSMutableString * newPart = [NSMutableString string];
        
        for (short i = 0; i < [keyOrder count]; i++)
            [newPart appendFormat:@"%c", [part characterAtIndex:[keyOrder[i] integerValue]]];
        
        [partsChanged addObject:newPart];
    }
    return partsChanged;
}


+ (NSArray *)readColumnsFrom:(NSArray *)parts with:(short)keyLength {
    
    NSMutableArray * result = [NSMutableArray array];
    
    for (short i = 0; i < keyLength; i++) {
        NSMutableString * column = [NSMutableString string];
        
        for (NSString * row in parts)
            [column appendFormat:@"%c", [row characterAtIndex:i]];
        
        [result addObject:column];
    }
    return result;
}


+ (bool)isAllowedKey:(NSString *)key {
    
    key = [key lowercaseString];
    short length = [key length];
    unichar buffer[length];
    [key getCharacters:buffer range:NSMakeRange(0, length)];
    
    bool repeated[LETTER_COUNT];     // for keeping track of used chars
    for (char i = 0; i < LETTER_COUNT; i++) repeated[i] = false;
    
    for (short i = 0; i < length; ++i) {
        if ((buffer[i] < 'a' || buffer[i] > 'z') && buffer[i] != ' ')
            return false;   // char not valid
        else if (repeated[buffer[i] - 'a'])
            return false;   // char already used
        else
            repeated[buffer[i] - 'a'] = true;
    }
    return true;
}

+ (NSString *)generateRandomKey {
    // generate random string with non-repeating 4-7 chars
    char keyLength = 4 + arc4random_uniform(4);
    NSMutableString * result = [NSMutableString string];
    
    for (char i = 0; i < keyLength; i++) {
        char ch = [Utils getRandomLetter];
        
        if([result rangeOfString:[NSString stringWithFormat:@"%c", ch]].location != NSNotFound)
            i--;
        else
            [result appendFormat:@"%c", ch];
    
    }
    return result;
}


@end
