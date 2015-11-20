#import <Foundation/Foundation.h>

@interface TranspositionCrack : NSObject


+ (NSString *)realWordsAnalysisKeyGuess:(NSString *)text;


+ (NSArray *)getAllKeysForText:(NSString *)text;

+ (NSArray *)getAllKeysWithLengths:(NSArray *)lengths;

+ (NSArray *)getAllPossibleKeysWithLength:(int)length;

+ (NSArray *)getAllPossibleKeysToLength:(int)length;


@end
