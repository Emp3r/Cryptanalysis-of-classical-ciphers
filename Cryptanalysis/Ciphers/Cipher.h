#import <Foundation/Foundation.h>

@protocol Cipher <NSObject>

// encryption & decryption
+ (NSString *)encrypt:(NSString *)text withKey:(NSString *)key;

+ (NSString *)decrypt:(NSString *)text withKey:(NSString *)key;


+ (bool)isAllowedKey:(NSString *)key;

+ (NSString *)generateRandomKey;


@end
