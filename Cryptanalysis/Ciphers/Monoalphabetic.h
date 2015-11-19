#import <Foundation/Foundation.h>
#import "Cipher.h"

@interface Monoalphabetic : Cipher

// encryption & decryption
+ (NSString *)encrypt:(NSString *)text with:(NSString *)key;

+ (NSString *)decrypt:(NSString *)text with:(NSString *)key;


+ (NSString *)fixKey:(NSString *)key;

+ (NSString *)fillToAllowedKey:(NSString *)key;


+ (bool)isAllowedKey:(NSString *)key;

+ (NSString *)generateRandomKey;


@end
