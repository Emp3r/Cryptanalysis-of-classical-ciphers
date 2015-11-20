#import <Foundation/Foundation.h>

@interface VigenereCrack : NSObject

// key length
+ (int)guessKeyLength:(NSString *)text;

+ (NSArray *)codedTextSplitted:(NSString *)text;

+ (NSArray *)findDistanceDivisors:(NSString *)text;


// frequency analysis
+ (NSString *)frequencyAnalysisKeyGuess:(NSString *)text;

+ (NSString *)breakWithLetterFrequency:(NSString *)text;


// frequent letters minimal distance attack
+ (NSString *)lettersDistanceKeyGuess:(NSString *)text;



@end
