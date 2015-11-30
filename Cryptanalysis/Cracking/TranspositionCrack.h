#import <Foundation/Foundation.h>

@interface TranspositionCrack : NSObject

// brute force - real words count
+ (NSString *)realWordsAnalysisKeyGuess:(NSString *)text;

+ (NSString *)findMostProbableKey:(NSString *)text fromKeys:(NSArray *)keys;

+ (NSArray *)getAllKeysForText:(NSString *)text maxLength:(int)maxLength;

+ (NSArray *)getAllKeysWithLengths:(NSArray *)lengths;

+ (NSArray *)getAllPossibleKeysWithLength:(int)length;

+ (NSArray *)getAllPossibleKeysToLength:(int)length;


// finding word attack
+ (NSString *)findingWordKeyGuess:(NSString *)text;

+ (NSArray *)makeKeysFromPairs:(NSDictionary *)pairs;

+ (NSArray *)makeLetterOrdersFromPairs:(NSDictionary *)pairs;

+ (void)getPermutations:(NSString *)word current:(int)current positions:(NSDictionary *)positions visited:(NSArray *)visited result:(NSMutableArray **)result;

+ (NSArray *)getAllWordsOfLength:(int)lengths;

+ (bool)hasSameChars:(NSString *)string1 and:(NSString *)string2;


@end
