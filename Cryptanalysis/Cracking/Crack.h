#import <Foundation/Foundation.h>

@protocol Crack <NSObject>


+ (NSString *)keyGuess:(NSString *)text;

+ (NSString *)breakCodedText:(NSString *)text;

+ (bool)isGuessedKey:(NSString *)guess equalToKey:(NSString *)key;


@end
