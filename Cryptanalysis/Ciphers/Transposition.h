#import <Foundation/Foundation.h>
#import "Cipher.h"

@interface Transposition : Cipher

// encryption & decryption
+ (NSString *)encrypt:(NSString *)text with:(NSString *)key;

+ (NSString *)decrypt:(NSString *)text with:(NSString *)key;


// marks each char of key by number (from 0 to n-1), then sorts chars and return their numbers in array
+ (NSArray *)makeKeyOrder:(NSString *)key;

+ (NSArray *)makeReverseKeyOrder:(NSString *)key;

// explodes text to array with strings of length partLength
+ (NSArray *)getTextParts:(NSString *)text length:(int)partLength;

// scrambles each text part by keyOrder
+ (NSArray *)getScrambledParts:(NSArray *)parts order:(NSArray *)keyOrder;


+ (NSArray *)readColumnsFrom:(NSArray *)parts length:(int)keyLength;


+ (bool)isAllowedKey:(NSString *)key;

+ (NSString *)generateRandomKey;


@end
