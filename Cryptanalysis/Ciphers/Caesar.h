#import <Foundation/Foundation.h>
#import "Cipher.h"

@interface Caesar : Cipher

// encryption & decryption
+ (NSString *)encrypt:(NSString *)text with:(NSString *)key;

+ (NSString *)decrypt:(NSString *)text with:(NSString *)key;


+ (NSString *)encrypt:(NSString *)text withChar:(char)key;

+ (NSString *)decrypt:(NSString *)text withChar:(char)key;


+ (char)shiftRight:(char)symbol with:(char)shift;

+ (char)shiftLeft:(char)symbol with:(char)shift;


+ (bool)isAllowedKey:(NSString *)key;

+ (NSString *)generateRandomKey;


@end
