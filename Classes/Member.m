//
//  Member.m
//  TableTest
//
//  Created by kristyan connolly on 20/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "Member.h"


@implementation Member

@synthesize firstName;
@synthesize lastName;
@synthesize teamName;
@synthesize fullName;
@synthesize memberID;

#pragma mark RKObjectMappable methods

/**
 * The property mapping dictionary. This method declares how elements in the JSON
 * are mapped to properties on the object.
 */

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"memberID",
			@"first_name", @"firstName",
			@"last_name", @"lastName",
			@"team_name", @"teamName",
			@"full_name", @"fullName",
			nil];
}

/**
 * Informs RestKit which properties contain the primary key values that
 * can be used to hydrate relationships to other objects. This hint enables
 * RestKit to automatically maintain true Core Data relationships between objects
 * in your local store.
 *
 * Here we have asked RestKit to connect the 'user' relationship by performing a
 * primary key lookup with the value in 'userID' property. This is the declarative
 * equivalent of doing self.user = [DBUser objectWithPrimaryKeyValue:self.userID];
 */
//+ (NSDictionary*)relationshipToPrimaryKeyPropertyMappings {
//	return [NSDictionary dictionaryWithKeysAndObjects:
//			@"user", @"userID",
//			nil];
//}

/**
 * Informs RestKit which property contains the primary key for identifying
 * this object. This is used to ensure that objects are updated
 */
+ (NSString*)primaryKeyProperty {
	return @"memberID";
}

- (void) dealloc {
	[memberID release];
	[firstName release];
	[lastName release];
	[teamName release];
	[fullName release];
	[super dealloc];
}



@end
