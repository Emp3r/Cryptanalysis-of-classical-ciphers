#import <Foundation/Foundation.h>

@interface MonoalphabeticCrack : NSObject

// unique words attack
+ (NSString *)uniqueWordsKeyGuess:(NSString *)text;


+ (NSDictionary *)findMatchesWithUniqueWords:(NSString *)text;


+ (NSDictionary *)makeSubstitutionTable:(NSString *)word subs:(NSString *)subs;

+ (bool)hasSameSubstitutionTables:(NSDictionary *)first and:(NSDictionary *)second;

+ (NSArray *)getAllUniqueWords;


// frequency analysis
+ (NSString *)frequencyAnalysisKeyGuess:(NSString *)text;


@end
