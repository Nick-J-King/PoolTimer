//  NSNumber+Additions.m
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


#import "NSNumber+Additions.h"

#import "NSDictionary+Additions.h"


@implementation NSNumber (Additions)


+ (NSNumber *)integerFromData:(NSDictionary *)data forKey:(NSString *)key {

    NSInteger integer = [[data objectForKeyOrNil:key] integerValue];
    
    return [NSNumber numberWithInteger:integer];
}


+ (NSNumber *)floatFromData:(NSDictionary *)data forKey:(NSString *)key {
    
    float floatNumber = [[data objectForKeyOrNil:key] floatValue];
    
    return [NSNumber numberWithFloat:floatNumber];
}


@end
