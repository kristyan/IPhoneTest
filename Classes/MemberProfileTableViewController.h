//
//  MemberProfileTableViewController.h
//  TableTest
//
//  Created by kristyan connolly on 10/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface MemberProfileTableViewController : BaseTableViewController {
    NSMutableDictionary* memberData;
	NSMutableArray* memberDataLabels;
	NSString* fullName;
}

@end
