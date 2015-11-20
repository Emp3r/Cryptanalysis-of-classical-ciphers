#import "Combinatorics.h"

@implementation Combinatorics

// combinations
+ (NSArray *)getCombinationArrays:(int)k from:(int)n {
    
    int one = 1;
    int * marker = &one;
    NSMutableArray * combinations = [[NSMutableArray alloc] init];
    
    [Combinatorics combinations:n need:k chosen:0 at:0 marker:marker result:&combinations];
    
    return combinations;
}

+ (NSArray *)getCombinationStrings:(int)k from:(int)n {
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    
    for (NSArray * array in [Combinatorics getCombinationArrays:k from:n])
        [result addObject:[array componentsJoinedByString:@""]];
    
    return result;
}


+ (NSArray *)getCombinations:(int)k fromArray:(NSArray *)chars {
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    NSArray * orders = [Combinatorics getCombinationArrays:k from:(int)[chars count]];
    
    for (NSArray * order in orders) {
        NSMutableArray * row = [[NSMutableArray alloc] init];
        
        for (NSNumber * n in order)
            [row addObject:chars[[n intValue]]];
        
        [result addObject:row];
    }
    return result;
}


+ (void)combinations:(int)pool need:(int)need chosen:(unsigned long)chosen at:(int)at marker:(int *)marker result:(NSMutableArray **)result {
    
    if (pool < need + at) return;
    
    if (!need) {
        NSMutableArray * row = [[NSMutableArray alloc] init];
        
        for (at = 0; at < pool; at++) {
            if (chosen & (*marker << at))
                [row addObject:@(at)];
        }
        [*result addObject:row];
        return;
    }
    
    [Combinatorics combinations:pool need:(need - 1) chosen:(chosen | (*marker << at)) at:(at + 1) marker:marker result:result];
    [Combinatorics combinations:pool need:need chosen:chosen at:(at + 1) marker:marker result:result];
}

// permutations
+ (NSArray *)getPermutationStrings:(NSArray *)chars {
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    NSArray * arrays = [Combinatorics getPermutationArrays:chars];
    
    for (NSArray * array in arrays)
        [result addObject:[array componentsJoinedByString:@""]];
    
    return result;
}

+ (NSArray *)getPermutationArrays:(NSArray *)chars {
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    NSMutableArray * output = [[NSMutableArray alloc] init];
    NSMutableArray * used = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [chars count]; i++)
        [used addObject:[NSNumber numberWithBool:false]];
    
    [Combinatorics permutation:chars to:output used:used level:0 result:&result];
    
    return result;
}


+ (void)permutation:(NSArray *)input to:(NSMutableArray *)output used:(NSMutableArray *)used level:(int)level result:(NSMutableArray **)result {
    
    if ([input count] == level) {
        [*result addObject:[output copy]];
        return;
    }
    level++;
    
    for (int i = 0; i < [input count]; i++) {
        if ([used[i] boolValue]) continue;
        
        used[i] = [NSNumber numberWithBool:true];
        [output addObject:input[i]];
        
        [Combinatorics permutation:input to:output used:used level:level result:result];
        used[i] = [NSNumber numberWithBool:false];
        [output removeLastObject];
    }
}


@end
