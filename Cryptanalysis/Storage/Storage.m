#import "Storage.h"

@implementation Storage


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


@end
