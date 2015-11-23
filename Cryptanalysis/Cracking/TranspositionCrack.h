#import <Foundation/Foundation.h>
#import "FileReader.h"

@interface TranspositionCrack : NSObject

// brute force - real words count
+ (NSString *)realWordsAnalysisKeyGuess:(NSString *)text;

+ (NSArray *)getAllKeysForText:(NSString *)text;

+ (NSArray *)getAllKeysWithLengths:(NSArray *)lengths;

+ (NSArray *)getAllPossibleKeysWithLength:(int)length;

+ (NSArray *)getAllPossibleKeysToLength:(int)length;


// finding word attack
+ (NSString *)findingWordKeyGuess:(NSString *)text;

+ (NSArray *)getAllWordsOfLengths:(NSArray *)lengths;
+ (NSArray *)getAllWordsOfLength:(int)lengths;
+ (FileReader *)getDictionaryFileReader;

+ (bool)hasSameChars:(NSString *)string1 and:(NSString *)string2;



@end
