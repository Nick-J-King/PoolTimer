//  Utils.h
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


#define UIColorFromRGBHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGB(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define UIColorFromRGBA(r, g, b, a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

NSString *getNeatAddressForStreetNumber(NSString *streetNumber, NSString *streetName, NSString *streetType, NSString *suburb, NSNumber *postcode, NSString *suffix);


@interface Utils : NSObject

+ (NSString *)currentDateString;
+ (NSDate *)mysqlDateTimeToDate:(NSString *)dateTime;
+ (NSDate *)mysqlDateToDate:(NSString *)date;
+ (NSString *)dateToMySQLString:(NSDate *)date;

+ (NSString *)prettyDateTime:(NSDate *)date;
+ (NSString *)prettyDate:(NSDate *)date;

+ (NSString *)progressCount:(NSInteger)count ofTotal:(NSInteger)total;

//- (void)testOnline;

+ (void)getTodayFromDate:(NSDate **)startDate toDate:(NSDate **)endDate withCalendar:(NSCalendar *)gregorian forDate:(NSDate *)forDate;
+ (void)getThisWeekFromDate:(NSDate **)startDate toDate:(NSDate **)endDate withCalendar:(NSCalendar *)gregorian forDate:(NSDate *)forDate;
+ (void)getThisMonthFromDate:(NSDate **)startDate toDate:(NSDate **)endDate withCalendar:(NSCalendar *)gregorian forDate:(NSDate *)forDate;

+ (BOOL)isCameraDeviceAvailable;
+ (BOOL)isVideoDeviceAvailable;

+ (void)createFolder:(NSURL *)path;
+ (BOOL)deleteMedia:(NSString *)fileName fromDocumentsFolder:(NSURL *)folder;

+ (void)clearCookies;

@end
