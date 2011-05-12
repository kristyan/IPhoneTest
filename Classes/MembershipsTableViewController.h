//
//  MembershipsTableViewController.h
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "BaseTableViewController.h"
@class TeamActivityTableViewController;	


@interface MembershipsTableViewController : BaseTableViewController <RKObjectLoaderDelegate> {
    NSMutableArray* memberships;
	TeamActivityTableViewController *teamActivityTableViewController;
}

@end
