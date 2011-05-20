//
//  BaseTableViewController.m
//  TableTest
//
//  Created by kristyan connolly on 10/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "BaseTableViewController.h"
#import "LoginViewController.h"
#import "User.h"

@implementation BaseTableViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    	
	// check if the current user is logged in here
	BOOL isLoggedIn = [[User currentUser] isLoggedIn];
	if (!isLoggedIn) {
	    // Display the login view as a modal view.
		LoginViewController *loginViewController = [[LoginViewController alloc] init];
		[self presentModalViewController:loginViewController animated:NO];
		[loginViewController release];
		
	}
}

- (void)loadView {
	[super loadView];
	self.view.backgroundColor = [UIColor darkGrayColor];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (UIView*) buildTitleHeaderView:(NSString*)title {
	UIView *containerView =
	[[[UIView alloc]
	  initWithFrame:CGRectMake(0, 0, 300, 60)]
	 autorelease];
	UILabel *headerLabel =
	[[[UILabel alloc]
	  initWithFrame:CGRectMake(10, 20, 300, 40)]
	 autorelease];
	headerLabel.text = title;
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.shadowColor = [UIColor blackColor];
	headerLabel.shadowOffset = CGSizeMake(0, 1);
	headerLabel.font = [UIFont boldSystemFontOfSize:22];
	headerLabel.backgroundColor = [UIColor clearColor];
	[containerView addSubview:headerLabel];
	self.tableView.tableHeaderView = containerView;
    return containerView;
}	

- (void)dealloc {
    [super dealloc];
}


@end

