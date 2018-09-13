//  NSDictionary+Additions.m
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


/**
 * Helper categories on NSDictionary.
 *
 */
@interface NSDictionary (Additions)

/**
 * Clean-up NSNulls from JSON dictionaries.
 * @param key The key to look for
 * @return The object from the dictionary or nil if that object is an NSNull.
 */
- (id)objectForKeyOrNil:(id)key;

/**
 * Clean-up NSNulls from JSON dictionaries.
 * @param keyPath The key path to look for
 * @return The object from the dictionary or nil if that object is an NSNull.
 */
- (id)objectForKeyPathOrNil:(id)keyPath;

- (NSArray *)arrayForKeyOrNil:(id)key;

// Number conversions

- (NSInteger)integerForKeyOrZero:(NSString *)key;
- (NSNumber *)integerNumberForKeyOrZero:(NSString *)key;

- (BOOL)booleanForKeyOrNo:(NSString *)key;
- (NSNumber *)booleanNumberForKeyOrNo:(NSString *)key;

- (float)floatForKeyOrZero:(NSString *)key;
- (NSNumber *)floatNumberForKeyOrZero:(NSString *)key;

- (NSDate *)dateForKeyOrNil:(NSString *)key;

@end
