//
//  BaseModel.h
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

// Posted when a content object has changed
extern NSString* const BaseModelDidChangeNotification;

/**
 * Abstract superclass for content models in the Teamer App. Provides
 * common property & method definitions for the system
 */
@interface BaseModel : RKObject {
	
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Common content properties

/**
 * A timestamp of when the object was created
 */
@property (nonatomic, retain) NSDate* createdAt;

/**
 * A timestamp of when the object was last modified
 */
@property (nonatomic, retain) NSDate* updatedAt;


////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Common relationships


////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Returns YES when the object does not have a primary key
 * for the remote system. This indicates that the object is unsaved
 */
- (BOOL)isNewRecord;

@end

