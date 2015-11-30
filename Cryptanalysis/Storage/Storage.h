#import <Foundation/Foundation.h>
#import "FileReader.h"

@interface Storage : NSObject

// array of available ciphers and attacks
+ (NSArray *)availableCiphers;

+ (NSArray *)availableCiphersNormalized;

+ (NSArray *)availableAttacks;

+ (NSArray *)availableAttacksFor:(int)cipher;


// file readers
+ (NSArray *)getAllDictionaryWords;

+ (NSArray *)getAllUniqueWords;


+ (FileReader *)dictionaryFileReader;

+ (FileReader *)uniqueFileReader;

+ (FileReader *)fileReaderForFile:(NSString *)fileName;


@end
