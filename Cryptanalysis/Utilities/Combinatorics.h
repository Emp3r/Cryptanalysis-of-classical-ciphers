#import <Foundation/Foundation.h>

@interface Combinatorics : NSObject

// combinations
+ (NSArray *)getCombinationArrays:(int)k from:(int)n;
+ (NSArray *)getCombinationStrings:(int)k from:(int)n;

+ (NSArray *)getCombinations:(int)k fromArray:(NSArray *)chars;

+ (void)combinations:(int)pool need:(int)need chosen:(unsigned long)chosen at:(int)at marker:(int *)marker result:(NSMutableArray **)result;


// permutations
+ (NSArray *)getPermutationArrays:(NSArray *)chars;
+ (NSArray *)getPermutationStrings:(NSArray *)chars;

+ (void)permutation:(NSArray *)input to:(NSMutableArray *)output used:(NSMutableArray *)used level:(int)level result:(NSMutableArray **)result;


@end
