//
//  BaseTableViewController.h
//  TableTest
//
//  Created by kristyan connolly on 10/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseTableViewController : UITableViewController {

}

/**
 * Utility for building a header view with a title
 * Subclasses that need a header view containing a title can call this.
 */
- (UIView*)buildTitleHeaderView:(NSString*)title;

@end
