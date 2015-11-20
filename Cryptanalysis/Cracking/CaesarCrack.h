#import <Foundation/Foundation.h>

@interface CaesarCrack : NSObject

// frequency analysis
+ (char)guessKeyLetterFrequency:(NSString *)text;

+ (NSString *)breakWithLetterFrequency:(NSString *)text;

+ (NSString *)frequencyAnalysisKeyGuess:(NSString *)text;


// real words analysis
+ (char)guessKeyRealWords:(NSString *)text;

+ (NSString *)breakWithRealWords:(NSString *)text;

+ (NSString *)realWordsAnalysisKeyGuess:(NSString *)text;


// frequent letters minimal distance attack
+ (NSString *)lettersDistanceKeyGuess:(NSString *)text;

+ (NSArray *)findSameDistanceCombination:(NSArray *)chars in:(NSArray *)combinations;

+ (bool)hasSameMinimalDistance:(NSArray *)array1 and:(NSArray *)array2;

+ (NSArray *)getCharCombinations:(NSArray *)chars chose:(int)chose from:(int)from;

+ (NSArray *)mapCharsToCombinations:(NSArray *)chars indexes:(NSArray *)indexes;


+ (NSDictionary *)mostUsedChars:(NSArray *)frequency size:(int)size;

+ (NSDictionary *)leastUsedChars:(NSArray *)frequency size:(int)size;


+ (int)minimalDistanceOfFirstChars:(NSString *)firstString and:(NSString *)secondString;

+ (int)minimalDistance:(char)firstChar and:(char)secondChar;


@end
