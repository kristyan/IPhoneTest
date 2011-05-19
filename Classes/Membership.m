//
//  membership.m
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//
#import "Membership.h"
#import "Environment.h"

@implementation Membership

@synthesize memberID;
@synthesize fullName;
@synthesize teamName;
@synthesize organiserName;
@synthesize teamSport;
@synthesize teamLocation;
@synthesize nextEventTitle;
@synthesize nextEventStartsAt;
@synthesize teamID;
@synthesize avatarThumbURL;
@synthesize avatarImageName;

#pragma mark RKObjectMappable methods

/**
 * The property mapping dictionary. This method declares how elements in the JSON
 * are mapped to properties on the object.
 */

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"memberID",
			@"full_name", @"fullName",
			@"team_name", @"teamName",
			@"team_organiser_name", @"organiserName",
			@"team_sport", @"teamSport",
			@"team_location", @"teamLocation",
			@"next_event_title", @"nextEventTitle",
			@"next_event_starts_at", @"nextEventStartsAt",
			@"team_id", @"teamID",
			@"avatar_thumb_url", @"avatarThumbURL",
			@"created_at", @"createdAt",
			@"updated_at", @"updatedAt",
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

- (NSString*)fullAvatarThumbURL {
    return [NSString stringWithFormat:@"%@%@", TeamerBaseURL, avatarThumbURL];
}

- (void) dealloc {
	[fullName release];
	[teamName release];
	[organiserName release];
	[teamSport release];
	[teamLocation release];
	[nextEventTitle release];
	[nextEventStartsAt release];
	[teamID release];
	[avatarThumbURL release];
	[avatarImageName release];
	[super dealloc];
}

@end

