#import "Storage.h"

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
+ (FileReader *)getDictionaryFileReader {
    NSString * lang = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    NSString * fileName = [NSString stringWithFormat:@"%@_dictionary", lang];
    return [Storage getFileReaderForFile:fileName];
}

+ (FileReader *)getUniqueFileReader {
    NSString * lang = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    NSString * fileName = [NSString stringWithFormat:@"%@_unique", lang];
    return [Storage getFileReaderForFile:fileName];
}

+ (FileReader *)getFileReaderForFile:(NSString *)fileName {
    NSString * path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    return [[FileReader alloc] initWithFilePath:path];
}


@end
