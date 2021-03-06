#import <Foundation/Foundation.h>
#import "Crack.h"

@interface MonoalphabeticCrack : NSObject <Crack>

// unique words attack
+ (NSString *)uniqueWordsKeyGuess:(NSString *)text;

+ (NSArray *)filterArray:(NSArray *)array numberOfUnknownChars:(int)count;

+ (NSString *)makeKey:(NSDictionary *)table;

+ (NSDictionary *)uniteTables:(NSArray *)tables;

+ (NSArray *)findLargestClique:(NSDictionary *)pairs;

+ (NSDictionary *)findMatchesWithUniqueWords:(NSArray *)words;

+ (NSDictionary *)makeSubstitutionTable:(NSString *)word subs:(NSString *)subs;

+ (bool)hasSameSubstitutionTables:(NSDictionary *)first and:(NSDictionary *)second;


// frequency analysis
+ (NSString *)frequencyAnalysisKeyGuess:(NSString *)text;


@end
