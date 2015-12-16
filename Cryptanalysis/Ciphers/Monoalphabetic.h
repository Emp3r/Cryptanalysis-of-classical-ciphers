#import <Foundation/Foundation.h>
#import "Cipher.h"

@interface Monoalphabetic : NSObject <Cipher>

// encryption & decryption
+ (NSString *)encrypt:(NSString *)text withKey:(NSString *)key;

+ (NSString *)decrypt:(NSString *)text withKey:(NSString *)key;


+ (NSString *)fixKey:(NSString *)key;

+ (NSString *)fillToAllowedKey:(NSString *)key;


+ (bool)isAllowedKey:(NSString *)key;

+ (NSString *)generateRandomKey;


@end
