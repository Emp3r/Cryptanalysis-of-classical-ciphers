#import <Foundation/Foundation.h>

@interface Storage : NSObject


// array of available ciphers and attacks
+ (NSArray *)availableCiphers;

+ (NSArray *)availableCiphersNormalized;

+ (NSArray *)availableAttacks;

+ (NSArray *)availableAttacksFor:(int)cipher;


@end
