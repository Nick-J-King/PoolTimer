//  Utils.m
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


#import "Utils.h"

#import "AppDelegate.h"

#import <MobileCoreServices/MobileCoreServices.h>


NSString *getNeatAddressForStreetNumber(NSString *streetNumber, NSString *streetName, NSString *streetType, NSString *suburb, NSNumber *postcode, NSString *suffix) {
    
    NSString *trimStreetNumber = [streetNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *trimStreetName = [streetName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *trimStreetType = [streetType stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *trimSuburb = [suburb stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *trimSuffix = [suffix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    bool bShowSuffix = !([trimSuffix isEqualToString:@""] || trimSuffix == nil);
    bool bShowType = !([trimStreetType isEqualToString:@""] || trimStreetType == nil);
    
    // Always show street number, street name, suburb and postcode.
    
    if (bShowSuffix) {
        if (bShowType) {
            return [NSString stringWithFormat:@"%@ %@ %@ %@, %@, %@", trimStreetNumber, trimSuffix, trimStreetName, trimStreetType, trimSuburb, postcode];
        }
        else {
            return [NSString stringWithFormat:@"%@ %@ %@, %@, %@", trimStreetNumber, trimSuffix, trimStreetName, trimSuburb, postcode];
        }
    }
    else {
        if (bShowType) {
            return [NSString stringWithFormat:@"%@ %@ %@, %@, %@", trimStreetNumber, trimStreetName, trimStreetType, trimSuburb, postcode];
        }
        else {
            return [NSString stringWithFormat:@"%@ %@, %@, %@", trimStreetNumber, trimStreetName, trimSuburb, postcode];
        }
    }
}


@implementation Utils


+ (NSString *)prettyDateTime:(NSDate *)date {
    
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"hh:mm a, dd MMM yyyy"];
    return [df stringFromDate:date];
}


+ (NSString *)prettyDate:(NSDate *)date {
    
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd MMM yyyy"];
    return [df stringFromDate:date];
}


+ (NSString *)progressCount:(NSInteger)count ofTotal:(NSInteger)total {

    if (total <= 1) {
        return @"";
    }

    return [NSString stringWithFormat:@" %ld of %ld", (long)count, (long)total];
}


+ (NSString *)currentDateString {

    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd-HHmmss"];
    return [df stringFromDate: [NSDate date]];
}


+ (NSDate *)mysqlDateTimeToDate:(NSString *)dateTime {
    
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat dateFromString:dateTime];
}


+ (NSDate *)mysqlDateToDate:(NSString *)dateTime {
    
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat dateFromString:dateTime];
}


+ (NSString *)dateToMySQLString:(NSDate *)date {
    
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat stringFromDate:date];
}


/*
- (void)testOnline
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    internetReachable = [Reachability reachabilityWithHostname:@"www.google.com.au"];
    
    // Internet is reachable
    internetReachable.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            appDelegate.online = [NSNumber numberWithBool:YES];
            DLog(@"Yayyy, we have the interwebs!");
        });
    };
    
    // Internet is not reachable
    internetReachable.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            appDelegate.online = [NSNumber numberWithBool:NO];
            DLog(@"Someone broke the internet :(");
        });
    };
    
    [internetReachable startNotifier];
}
*/


+ (void)getTodayFromDate:(NSDate **)startDate toDate:(NSDate **)endDate withCalendar:(NSCalendar *)gregorian forDate:(NSDate *)forDate {
    
    NSDateComponents *dateComponents;
    dateComponents = [gregorian components: NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:forDate];
    
    [dateComponents setHour:0];
    [dateComponents setMinute:00];
    [dateComponents setSecond:00];
    
    *startDate = [gregorian dateFromComponents:dateComponents];
    
    [dateComponents setHour:23];
    [dateComponents setMinute:59];
    [dateComponents setSecond:59];
    
    *endDate = [gregorian dateFromComponents:dateComponents];
}


+ (void)getThisWeekFromDate:(NSDate **)startDate toDate:(NSDate **)endDate withCalendar:(NSCalendar *)gregorian forDate:(NSDate *)forDate {
    
    NSDateComponents *dateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:forDate];
    [dateComponents setDay:[dateComponents day] - [dateComponents weekday] + 1];
    
    [dateComponents setHour:0];
    [dateComponents setMinute:00];
    [dateComponents setSecond:00];
    
    *startDate = [gregorian dateFromComponents:dateComponents];
    
    dateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:forDate];
    [dateComponents setDay:[dateComponents day] + 7 - [dateComponents weekday]];
    
    [dateComponents setHour:23];
    [dateComponents setMinute:59];
    [dateComponents setSecond:59];
    
    *endDate = [gregorian dateFromComponents:dateComponents];
}


+ (void)getThisMonthFromDate:(NSDate **)startDate toDate:(NSDate **)endDate withCalendar:(NSCalendar *)gregorian forDate:(NSDate *)forDate {
    
    NSDateComponents *dateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:forDate];
    
    [dateComponents setDay:1];
    
    [dateComponents setHour:0];
    [dateComponents setMinute:00];
    [dateComponents setSecond:00];
    
    *startDate = [gregorian dateFromComponents:dateComponents];
    
    [dateComponents setMonth:[dateComponents month] + 1];
    [dateComponents setDay:1];
    
    [dateComponents setHour:23];
    [dateComponents setMinute:59];
    [dateComponents setSecond:59];
    
    *endDate = [gregorian dateFromComponents:dateComponents];
}


+ (BOOL)isCameraDeviceAvailable {
    
    BOOL isCameraAvailable = NO;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]
            || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            
            isCameraAvailable = YES;
        }
    }

    return isCameraAvailable;
}


+ (BOOL)isVideoDeviceAvailable {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

        return NO;
    }
    
    if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]
     && ![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {

        return NO;
    }
    
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];

    if (![availableMediaTypes containsObject:(NSString *)kUTTypeMovie]) {

        return NO;
    }

    return YES;
}


// Make sure the required folders exist.

+ (void)createFolder:(NSURL *)path {
    
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:[path path] withIntermediateDirectories:YES attributes:nil error:&error];

    if (error != nil) {
        DLog(@"error creating folder: %@", error);
    }
}


+ (BOOL)deleteMedia:(NSString *)fileName fromDocumentsFolder:(NSURL *)folder {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [[folder URLByAppendingPathComponent:fileName] path];

    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];

    return success;
}


+ (void)clearCookies {

    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];

    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }

    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
