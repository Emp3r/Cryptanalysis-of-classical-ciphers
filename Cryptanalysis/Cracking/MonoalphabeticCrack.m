#import "MonoalphabeticCrack.h"
#import "Monoalphabetic.h"
#import "Utils.h"
#import "Language.h"
#import "Storage.h"

@implementation MonoalphabeticCrack

// unique words attack
+ (NSString *)uniqueWordsKeyGuess:(NSString *)text {
    
    text = [Utils normalizeLeaveSpaces:text];
    NSArray * words = [text componentsSeparatedByString:@" "];
    NSDictionary * matches = [MonoalphabeticCrack findMatchesWithUniqueWords:words];
    NSArray * clique = [MonoalphabeticCrack findLargestClique:matches];
    NSDictionary * table = [MonoalphabeticCrack uniteTables:clique];
    
    NSLog(@"\n text length: %d, matches: %d,  clique: %d, united: %d", text.length, matches.count, clique.count, table.count);
    //NSLog(@"%@", table);
    
    //while ([table count] < LETTER_COUNT) {
        // udělat z table klíč, zašifrovat text, rozdělit text na words a najít všechny slova s jednou hvězdičkou. (pokud žádné nejsou tak break;)
        // pro všechny slova s jednou * zkusíme najít ve slovníku odpovídající možné slovo X
        // pokud je slovo X jen jedno, doplníme do table substituci z X
        
    //}
    
    return [MonoalphabeticCrack makeKey:table];
}


+ (NSString *)makeKey:(NSDictionary *)table {
    
    NSMutableString * result = [[NSMutableString alloc] init];
    
    for (int i = 0; i < LETTER_COUNT; i++) {
        NSString * letter = [NSString stringWithFormat:@"%c", ('a' + i)];
        
        if ([[table allKeys] containsObject:letter])
            [result appendString:table[letter]];
        else
            [result appendString:@"*"];
    }
    return result;
}


+ (NSDictionary *)uniteTables:(NSArray *)tables {
    
    NSMutableDictionary * unitedTable = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary * t in tables)
        [unitedTable addEntriesFromDictionary:t];
    
    return unitedTable;
}

+ (NSArray *)findLargestClique:(NSDictionary *)pairs {
    
    NSMutableArray * clique = [[NSMutableArray alloc] init];
    NSMutableArray * tables = [[NSMutableArray alloc] init];
    
    for (NSString * k in [pairs allKeys])
        [tables addObject:[MonoalphabeticCrack makeSubstitutionTable:k subs:pairs[k]]];
    
    for (int i = 0; i < ([tables count] - 1); i++) {
        @autoreleasepool {
            NSMutableArray * temp = [NSMutableArray arrayWithObject:tables[i]];
            
            for (int j = (i + 1); j < [tables count]; j++) {
                bool hasSameTable = true;
                
                for (NSDictionary * d in temp)
                    if (![MonoalphabeticCrack hasSameSubstitutionTables:d and:tables[j]])
                        hasSameTable = false;
                
                if (hasSameTable)
                    [temp addObject:tables[j]];
            }
            
            if ([temp count] > [clique count])
                clique = [temp copy];
        }
    }
    return clique;
}


+ (NSDictionary *)findMatchesWithUniqueWords:(NSArray *)words {
    
    NSMutableDictionary * matches = [[NSMutableDictionary alloc] init];
    NSArray * uniques = [Storage getAllUniqueWords];
    
    for (NSString * w in words) {
        @autoreleasepool {
            if (![[matches allKeys] containsObject:w]) {
                for (NSString * u in uniques) {
                    if ([[Utils getCanonicalForm:w] isEqualToString:[Utils getCanonicalForm:u]]) {
                        [matches setObject:u forKey:w];
                        break;
                    }
                }
            }
        }
    }
    return matches;
}

+ (NSDictionary *)makeSubstitutionTable:(NSString *)word subs:(NSString *)subs {
    
    NSMutableDictionary * result = [[NSMutableDictionary alloc] init];
    int size = MIN([word length], [subs length]);
    
    for (int i = 0; i < size; i++) {
        [result setObject:[NSString stringWithFormat:@"%c", [subs characterAtIndex:i]]
                   forKey:[NSString stringWithFormat:@"%c", [word characterAtIndex:i]]];
    }
    return result;
}

+ (bool)hasSameSubstitutionTables:(NSDictionary *)first and:(NSDictionary *)second {
    
    for (NSString * f in [first allKeys]) {
        NSString * value = [first objectForKey:f];
        NSString * s = [second objectForKey:f];
        
        if ((s && [s isEqualToString:value]) ||
            (!s && ![[second allValues] containsObject:value])) {
            continue;
        }
        else {
            return false;
        }
    }
    return true;
}


// frequency analysis
+ (NSString *)frequencyAnalysisKeyGuess:(NSString *)text {
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    NSArray * frequency = [Utils lettersFrequency:text];
    NSArray * expected = Language.expectedFrequency;
    bool freeLetters[LETTER_COUNT];
    for (char i = 0; i < LETTER_COUNT; i++) freeLetters[i] = true;
    
    NSLog(@"%@ \n %@", frequency, expected);
    
    for (char i = 0; i < LETTER_COUNT; i++) {
        float actualLetterFrequency = [frequency[i] floatValue];
        float smallestDifference = FLT_MAX;
        char bestLetterGuess = 0;
        
        for (char j = 0; j < LETTER_COUNT; j++) {
            float difference = fabsf(actualLetterFrequency - [expected[j] floatValue]);
            
            if (difference < smallestDifference && freeLetters[j]) {
                smallestDifference = difference;
                bestLetterGuess = j;
            }
        }
        freeLetters[bestLetterGuess] = false;
        [result addObject:[NSString stringWithFormat:@"%c", ('a' + bestLetterGuess)]];
    }
    return [result componentsJoinedByString:@""];
}


@end
