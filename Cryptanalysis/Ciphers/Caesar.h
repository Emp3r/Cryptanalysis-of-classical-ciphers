#import <Foundation/Foundation.h>
#import "Cipher.h"

@interface Caesar : NSObject <Cipher>

// encryption & decryption
+ (NSString *)encrypt:(NSString *)text withKey:(NSString *)key;

+ (NSString *)decrypt:(NSString *)text withKey:(NSString *)key;


+ (NSString *)encrypt:(NSString *)text withChar:(char)key;

+ (NSString *)decrypt:(NSString *)text withChar:(char)key;


+ (char)shiftRight:(char)symbol with:(char)shift;

+ (char)shiftLeft:(char)symbol with:(char)shift;


+ (bool)isAllowedKey:(NSString *)key;

+ (NSString *)generateRandomKey;


@end
