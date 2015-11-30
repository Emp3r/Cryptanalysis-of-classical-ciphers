#import "Storage.h"
#import "Utils.h"

@implementation Storage

// array of available ciphers and attacks
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
    return [Storage availableAttacks][cipherIndex];
}


// file readers
+ (NSArray *)getAllDictionaryWords {
    
    NSMutableArray * words = [[NSMutableArray alloc] init];
    FileReader * reader = [Storage dictionaryFileReader];
    
    NSString * line = nil;
    while ((line = [reader readLine])) {
        line = [Utils removeWhiteEnd:line];
        [words addObject:line];
    }
    return words;
}

+ (NSArray *)getAllUniqueWords {
    
    NSMutableArray * words = [[NSMutableArray alloc] init];
    FileReader * reader = [Storage uniqueFileReader];
    
    NSString * line = nil;
    while ((line = [reader readLine])) {
        line = [Utils removeWhiteEnd:line];
        [words addObject:line];
    }
    return words;
}



+ (FileReader *)dictionaryFileReader {
    NSString * lang = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    NSString * fileName = [NSString stringWithFormat:@"%@_dictionary", lang];
    return [Storage fileReaderForFile:fileName];
}

+ (FileReader *)uniqueFileReader {
    NSString * lang = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    NSString * fileName = [NSString stringWithFormat:@"%@_unique", lang];
    return [Storage fileReaderForFile:fileName];
}

+ (FileReader *)fileReaderForFile:(NSString *)fileName {
    NSString * path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    return [[FileReader alloc] initWithFilePath:path];
}


@end
