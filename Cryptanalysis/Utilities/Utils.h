#import <Foundation/Foundation.h>

@interface Utils : NSObject

// returns lowercased parameter string with letters only ('a' - 'z')
+ (NSString *)normalize:(NSString *)string;
// removes white spaces and break lines in the end of given string
+ (NSString *)removeWhiteEnd:(NSString *)string;
// á, ä -> a   etc..
+ (NSString *)rewriteTextToASCIIChars:(NSString *)text;

// allowed: numbers, space, dot, coma
+ (bool)isAllowedSymbol:(char)symbol;

// returns array with numbers of occurrences for each letter ([0] is for 'a', [25] for 'z')
+ (NSArray *)lettersCount:(NSString *)string;
+ (NSArray *)lettersFrequency:(NSString *)string;
+ (NSDictionary *)frequencyDictionary:(NSArray *)frequency;

// returns difference (deviation) between given array and expected lang. letter frequency
+ (float)frequencyDifference:(NSArray *)frequencies;

// returns number of real english words in text
+ (int)realWordsCount:(NSString *)string;


// returns random letter from 'a' to 'z'
+ (char)getRandomLetter;

// remove letter duplicates
+ (NSString *)removeDuplicates:(NSString *)text;


// get canonical form of the string
+ (NSString *)getCanonicalForm:(NSString *)word;

// array full of zeros (NSNumber with 0)
+ (NSArray *)makeNumberArrayWith:(int)elements;
+ (NSArray *)makeArraysArrayWith:(int)elements;

+ (NSArray *)makeCharArrayFrom:(NSString *)string;

+ (NSArray *)sortNestedArray:(NSArray *)array;


+ (NSArray *)getAllDivisors:(int)number;
+ (NSArray *)getDivisors:(int)number min:(int)min;
+ (NSArray *)getDivisors:(int)number max:(int)max;
+ (NSArray *)getDivisors:(int)number min:(int)min max:(int)max;


@end
