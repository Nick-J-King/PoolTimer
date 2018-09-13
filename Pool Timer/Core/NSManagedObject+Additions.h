//  NSManagedObject+Additions.h
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.

/**
 "NSManagedObject+Additions" is a category on "NSManagedObject" that
 provides helper methods for eliminating boiler plate code.
 */
@interface NSManagedObject (Additions)

/**
 Returns the name of the entity.
 
 @return The name of the entity.
 */
+ (NSString *)entityName;

/**
 Creates, configures, and returns an instance of the class for the entity.
 
 @param context The managed object context to use.
 
 @return A new, autoreleased, fully configured instance of the class for the entity. 
 The instance has its entity description set and is inserted it into the "context".
 */
+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context;

- (NSDictionary *)managedObjectToDictionary;

@end
