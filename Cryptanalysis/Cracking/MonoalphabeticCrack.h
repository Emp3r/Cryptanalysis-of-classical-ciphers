#import <Foundation/Foundation.h>

@interface MonoalphabeticCrack : NSObject

// unique words attack
+ (NSString *)uniqueWordsKeyGuess:(NSString *)text;


+ (NSString *)makeKey:(NSDictionary *)table;

+ (NSDictionary *)uniteTables:(NSArray *)tables;

+ (NSArray *)findLargestClique:(NSDictionary *)pairs;

+ (NSDictionary *)findMatchesWithUniqueWords:(NSArray *)words;

+ (NSDictionary *)makeSubstitutionTable:(NSString *)word subs:(NSString *)subs;

+ (bool)hasSameSubstitutionTables:(NSDictionary *)first and:(NSDictionary *)second;


// frequency analysis
+ (NSString *)frequencyAnalysisKeyGuess:(NSString *)text;


@end
