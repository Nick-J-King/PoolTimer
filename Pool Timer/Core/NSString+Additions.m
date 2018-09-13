//  NSString+Additions.m
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


#import "NSString+Additions.h"


@implementation NSString (Additions)


// Append a string with a separator.
// If either is blank, then the separator is not used.

- (NSString *)appendString:(NSString *)string withSeparator:(NSString *)separator {

    if ([self length] == 0) {
        return string;
    }

    if ([string length] == 0) {
        return self;
    }

    return [NSString stringWithFormat:@"%@%@%@", self, separator, string];
}


+ (NSString *)stringSingular:(NSString *)singular orPlural:(NSString *)plural withNumber:(NSInteger)number {

    if (number == 0) {
        return [NSString stringWithFormat:@"0 %@", plural];
    }

    if (number == 1) {
        return [NSString stringWithFormat:@"1 %@", singular];
    }

    return [NSString stringWithFormat:@"%ld %@", (long)number, plural];
}


+ (NSString *)stringSingular:(NSString *)singular orPlural:(NSString *)plural withPositiveNumber:(NSInteger)number {

    if (number == 0) {
        return @"";
    }

    if (number == 1) {
        return [NSString stringWithFormat:@"1 %@", singular];
    }
    
    return [NSString stringWithFormat:@"%ld %@", (long)number, plural];
}


@end
