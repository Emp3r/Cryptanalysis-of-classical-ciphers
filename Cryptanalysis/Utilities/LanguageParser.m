#import "LanguageParser.h"

@interface LanguageParser ()

@property NSXMLParser *parser;
@property NSString *element;

@end

@implementation LanguageParser

- (id)init {
    if ((self = [super init])) {
        self.frequency = [[NSMutableArray alloc] init];
        self.words = [[NSMutableArray alloc] init];
        self.bigrams = [[NSMutableArray alloc] init];
        self.trigrams = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parseXmlFromFile:(NSString *)fileName {
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"xml"];
    
    self.parser = [[NSXMLParser alloc] initWithContentsOfURL:path];
    self.parser.delegate = self;
    [self.parser parse];
                   
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    
    self.element = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([self.element isEqualToString:@"letter"]) {
        [self.frequency addObject:[NSNumber numberWithFloat:[string floatValue]]];
    }
    else if ([self.element isEqualToString:@"word"]) {
        [self.words addObject:string];
    }
    else if ([self.element isEqualToString:@"bi"]) {
        [self.bigrams addObject:string];
    }
    else if ([self.element isEqualToString:@"tri"]) {
        [self.trigrams addObject:string];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    self.element = nil;
}


@end
