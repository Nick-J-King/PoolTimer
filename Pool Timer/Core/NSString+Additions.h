//	NSString+Additions.h
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


@interface NSString (Additions)

- (NSString *)appendString:(NSString *)string withSeparator:(NSString *)separator;
+ (NSString *)stringSingular:(NSString *)singular orPlural:(NSString *)plural withNumber:(NSInteger)number;
+ (NSString *)stringSingular:(NSString *)singular orPlural:(NSString *)plural withPositiveNumber:(NSInteger)number;

@end
