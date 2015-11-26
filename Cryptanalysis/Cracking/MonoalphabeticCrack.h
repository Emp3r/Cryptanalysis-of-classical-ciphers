#import <Foundation/Foundation.h>

@interface MonoalphabeticCrack : NSObject

// unique words attack
+ (NSString *)uniqueWordsKeyGuess:(NSString *)text;


+ (NSDictionary *)findMatchesWithUniqueWords:(NSString *)text;

+ (NSArray *)getAllUniqueWords;


// frequency analysis
+ (NSString *)frequencyAnalysisKeyGuess:(NSString *)text;


@end
