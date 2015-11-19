#import <Foundation/Foundation.h>

@interface Language : NSObject

// number of letters in alphabet as constant
extern const short LETTER_COUNT;

// getters for static variables
+ (NSArray *) expectedFrequency;
+ (NSArray *) mostUsedWords;
+ (NSArray *) bigrams;
+ (NSArray *) trigrams;


// change language - set all extern arrays
+ (bool)setLanguage:(NSString *)fileName;

// gets array of available language stat files
+ (NSArray *)availableLanguageFiles;

// language stat files without ".xml" extensions
+ (NSArray *)availableLanguageStats;

// fix file url if needed
+ (NSString *)fixFileName:(NSString *)fileName;

@end
