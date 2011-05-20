//
//  TeamMembersTableViewController.h
//  TableTest
//
//  Created by kristyan connolly on 20/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "BaseTableViewController.h"

@interface TeamMembersTableViewController : BaseTableViewController <RKObjectLoaderDelegate> {
    NSMutableArray* members;
	NSNumber* teamID;
}

@property (nonatomic, retain) NSNumber* teamID;

@end
