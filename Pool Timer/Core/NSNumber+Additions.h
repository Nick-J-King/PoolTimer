//	NSNumber+Additions.h
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


@interface NSNumber (Additions)

+ (NSNumber *)integerFromData:(NSDictionary *)data forKey:(NSString *)key;
+ (NSNumber *)floatFromData:(NSDictionary *)data forKey:(NSString *)key;

@end
