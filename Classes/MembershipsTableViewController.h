//
//  MembershipsTableViewController.h
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@class TeamActivityTableViewController;	


@interface MembershipsTableViewController : UITableViewController <RKObjectLoaderDelegate> {
    NSMutableArray* memberships;
	TeamActivityTableViewController *teamActivityTableViewController;
}

@end
