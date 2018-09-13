//  NSDictionary+Additions.m
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


#import "NSDictionary+Additions.h"

#import "Utils.h"


@implementation NSDictionary (MDMAdditions)


/**
 * Clean-up NSNulls from JSON dictionaries.
 * @param The key to look for
 * @return The object from the dictionary or nil if that object is an NSNull.
 */
- (id)objectForKeyOrNil:(id)key {
    
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return object;
}


/**
 * Clean-up NSNulls from JSON dictionaries.
 * @param The key path to look for
 * @return The object from the dictionary or nil if that object is an NSNull.
 */
- (id)objectForKeyPathOrNil:(id)keyPath {
    
    id object = [self valueForKeyPath:keyPath];
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return object;
}


- (NSArray *)arrayForKeyOrNil:(id)key {
    
    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return object;
}


#pragma mark - Number conversions


- (NSInteger)integerForKeyOrZero:(NSString *)key {
    
    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSString class]]) {
        return 0;
    }
    return [object integerValue];
}


- (NSNumber *)integerNumberForKeyOrZero:(NSString *)key {
    
    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSString class]]) {
        return @0;
    }
    return [NSNumber numberWithInteger:[object integerValue]];
}


- (BOOL)booleanForKeyOrNo:(NSString *)key {

    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSString class]]) {
        return NO;
    }
    return [object boolValue];
}


- (NSNumber *)booleanNumberForKeyOrNo:(NSString *)key {

    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSString class]]) {
        return 0;
    }
    return [NSNumber numberWithBool:[object boolValue]];
}


- (float)floatForKeyOrZero:(NSString *)key {
    
    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSString class]]) {
        return 0.0;
    }
    return [object floatValue];
}


- (NSNumber *)floatNumberForKeyOrZero:(NSString *)key {
    
    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSString class]]) {
        return @0.0;
    }
    return [NSNumber numberWithFloat:[object floatValue]];
}


- (NSDate *)dateForKeyOrNil:(NSString *)key {
    
    NSString *tmpString = [self objectForKeyOrNil:key];

    if (tmpString != nil) {
        return [Utils mysqlDateTimeToDate:tmpString];
    }
    return nil;
}


@end
