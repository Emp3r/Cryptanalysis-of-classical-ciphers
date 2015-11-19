#import <Foundation/Foundation.h>

@interface VigenereCrack : NSObject

// key length
+ (int *)findDistanceDivisor:(NSString *)text;

+ (NSArray *)findDistanceDivisors:(NSString *)text;

+ (int)guessKeyLength:(NSString *)text;

// frequency analysis
+ (NSArray *)codedTextSplitted:(NSString *)text;

+ (NSString *)guessKeyLetterFrequency:(NSString *)text;

+ (NSString *)breakWithLetterFrequency:(NSString *)text;


@end
