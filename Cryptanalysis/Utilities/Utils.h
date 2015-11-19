#import <Foundation/Foundation.h>

@interface Utils : NSObject


// array of available ciphers and attacks
+ (NSArray *)availableCiphers;
+ (NSArray *)availableCiphersNormalized;
+ (NSArray *)availableAttacks;
+ (NSArray *)availableAttacksFor:(int)cipher;

// returns lowercased parameter string
// with letters only ('a' - 'z')
+ (NSString *)normalize:(NSString *)string;

// allowed: numbers, space, dot, coma
+ (bool)isAllowedSymbol:(char)symbol;


// returns array with numbers of occurrences for
// each letter ([0] is for 'a', [25] for 'z')
+ (NSArray *)lettersCount:(NSString *)string;
+ (NSArray *)lettersFrequency:(NSString *)string;
+ (NSDictionary *)frequencyDictionary:(NSArray *)frequency;

// returns difference (deviation) between given array and expected lang. letter frequency
+ (float)frequencyDifference:(NSArray *)frequencies;

// returns number of real english words in text
+ (int)realWordsCount:(NSString *)string;


// returns random letter from 'a' to 'z'
+ (char)getRandomLetter;

////returns random key with no letters repeating
//+ (NSString *)randomKey:(int)length;

// remove letter duplicates
+ (NSString *)removeDuplicates:(NSString *)text;


// get canonical form of the string
+ (NSString *)getCanonicalForm:(NSString *)word;

// array full of zeros (NSNumber with 0)
+ (NSArray *)makeNumberArrayWith:(int)elements;

+ (NSArray *)makeCharArrayFrom:(NSString *)string;

+ (NSArray *)sortNestedArray:(NSArray *)array;


+ (NSArray *)getAllDivisors:(int)number;
+ (NSArray *)getAllDivisors:(int)number max:(int)maxNumber;


@end
