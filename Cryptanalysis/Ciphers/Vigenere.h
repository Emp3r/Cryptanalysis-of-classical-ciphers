#import <Foundation/Foundation.h>
#import "Cipher.h"

@interface Vigenere : Cipher

// encryption & decryption
+ (NSString *)encrypt:(NSString *)text with:(NSString *)key;

+ (NSString *)decrypt:(NSString *)text with:(NSString *)key;


+ (bool)isAllowedKey:(NSString *)key;

+ (NSString *)generateRandomKey;


@end
