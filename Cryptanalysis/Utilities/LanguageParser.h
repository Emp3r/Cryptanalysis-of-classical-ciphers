#import <Foundation/Foundation.h>

@interface LanguageParser : NSObject <NSXMLParserDelegate>

@property NSMutableArray *frequency;
@property NSMutableArray *words;
@property NSMutableArray *bigrams;
@property NSMutableArray *trigrams;


- (void)parseXmlFromFile:(NSString *)fileName;


@end
