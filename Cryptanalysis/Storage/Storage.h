#import <Foundation/Foundation.h>
#import "FileReader.h"

@interface Storage : NSObject

// array of available ciphers and attacks
+ (NSArray *)availableCiphers;

+ (NSArray *)availableCiphersNormalized;

+ (NSArray *)availableAttacks;

+ (NSArray *)availableAttacksFor:(int)cipher;


// file readers
+ (FileReader *)getDictionaryFileReader;

+ (FileReader *)getUniqueFileReader;

+ (FileReader *)getFileReaderForFile:(NSString *)fileName;


@end
