//
//  membership.h
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//


#import "BaseModel.h"

/**
 * Models a Membership in the Teamer App. Users have
 * memberships for each team they are a member of.
 */
@interface Membership : BaseModel {
}


@property (nonatomic, retain) NSString* fullName;
@property (nonatomic, retain) NSString* teamName;
@property (nonatomic, retain) NSString* organiserName;
@property (nonatomic, retain) NSString* teamSport;
@property (nonatomic, retain) NSString* teamLocation;
@property (nonatomic, retain) NSString* nextEventTitle;
@property (nonatomic, retain) NSString* nextEventStartsAt;
@property (nonatomic, retain) NSNumber* teamID;
@property (nonatomic, retain) NSString* avatarThumbURL;
@property (nonatomic, retain) NSString* avatarImageName;


- (NSString*)fullAvatarThumbURL;


#pragma mark Relationship properties


/**
 * The numeric primary key for this Membership in the remote backend system
 */
@property (nonatomic, retain) NSNumber* memberID;

@end
