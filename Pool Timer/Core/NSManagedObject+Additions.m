//  NSManagedObject+Additions.m
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


#import "NSManagedObject+Additions.h"

#import "Utils.h"


@implementation NSManagedObject (Additions)


+ (NSString *)entityName {

    return NSStringFromClass(self);
}


+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context {
    
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}


- (NSDictionary *)managedObjectToDictionary {

    NSMutableDictionary *fields = [NSMutableDictionary dictionary];
    for (NSAttributeDescription *attribute in [[self entity] properties]) {

        NSString *attributeName = attribute.name;
        id attributeValue = [self valueForKey:attributeName];
        if (attributeValue && ([attributeValue isKindOfClass:[NSString class]] || [attributeValue isKindOfClass:[NSNumber class]] || [attributeValue isKindOfClass:[NSDate class]]))  {
            if ([attributeValue isKindOfClass:[NSDate class]]) {    // >>> Check if the date conversion is needed...
                [fields setObject:[Utils dateToMySQLString:attributeValue] forKey:attributeName];
            }
            else {
                [fields setObject:attributeValue forKey:attributeName];
            }
        }
    }
    
    return fields;
}


@end
