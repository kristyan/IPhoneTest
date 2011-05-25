//
//  Member.h
//  TableTest
//
//  Created by kristyan connolly on 20/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


@interface Member : BaseModel {
}

@property (nonatomic, retain) NSString* firstName;
@property (nonatomic, retain) NSString* lastName;
@property (nonatomic, retain) NSString* teamName;
@property (nonatomic, retain) NSString* fullName;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* avatarThumbURL;

/**
 * The numeric primary key of this User in the remote backend system
 */
@property (nonatomic, retain) NSNumber* memberID;

- (NSString*)fullAvatarThumbURL;

@end
