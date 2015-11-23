#import "Language.h"
#import "LanguageParser.h"
#import "Utils.h"

@implementation Language


const short LETTER_COUNT = 26;

static NSArray * expectedFrequency;
static NSArray * mostUsedWords;
static NSArray * bigrams;
static NSArray * trigrams;


+ (NSArray *) expectedFrequency {
    @synchronized(self) {
        return expectedFrequency;
    }
}
+ (NSArray *) mostUsedWords {
    @synchronized(self) {
        return mostUsedWords;
    }
}
+ (NSArray *) bigrams {
    @synchronized(self) {
        return bigrams;
    }
}
+ (NSArray *) trigrams {
    @synchronized(self) {
        return trigrams;
    }
}


+ (bool)setLanguage:(NSString *)fileName {
    
    LanguageParser *parser = [[LanguageParser alloc] init];
    
    [parser parseXmlFromFile:fileName];
    
    /*
    char i = 0;
    for (NSNumber *num in [parser frequency]) {
        expectedFrequency[i] = [num floatValue];
        i++;
    } */
    
    expectedFrequency = [parser frequency];
    mostUsedWords = [parser words];
    bigrams = [parser bigrams];
    trigrams = [parser trigrams];
    
    return true;
}

+ (NSArray *)availableLanguageFiles {
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *dirContent = [fileManager contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"self ENDSWITH '.xml'"];
    NSArray *languages = [dirContent filteredArrayUsingPredicate:filter];
    
    return languages;
}

+ (NSArray *)availableLanguageStats {
    
    NSArray *files = [Language availableLanguageFiles];
    NSMutableArray *languages = [[NSMutableArray alloc] init];
    
    for (NSString* file in files) {
        // cut ".xml" extension from the file name
        [languages addObject:[file substringToIndex:[file length] - 4]];
    }
    
    return languages;
}

// setLanguage init moved to AppDelegate.swift, func application
// because it loads when app loads, not when class Language is first used
/*
 + (void)initialize {
 [Language setLanguage:@"English"];
 }
 */

+ (NSString *)fixFileName:(NSString *)fileName {
    
    NSString *pattern = @".xml$";
    NSRange range = NSMakeRange(0, [fileName length]);
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSRange match = [regex rangeOfFirstMatchInString:fileName options:NSMatchingReportProgress range:range];
    
    // add ".xml" extension if needed
    if (match.location == NSNotFound) {
        NSMutableString * result = [NSMutableString stringWithString:fileName];
        [result appendString:@".xml"];
        return result;
    }
    else {
        return fileName;
    }
}

@end
