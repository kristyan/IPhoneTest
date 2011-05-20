    //
//  MembershipsTableViewController.m
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "MembershipsTableViewController.h"
#import "Membership.h"
#import "User.h"
#import "MemberItemCell.h"
#import "TeamMembersTableViewController.h"
#import "LoginViewController.h"


/**
 * The HTTP Header Field we transmit the authentication token obtained
 * during login/sign-up back to the server. This token is verified server
 * side to establish an authenticated session
 */
@implementation MembershipsTableViewController

- (id) init {
	[super initWithStyle:UITableViewStyleGrouped]; //Grouped or plain style for table
	
	memberships =[[NSMutableArray alloc] init];
	
	// set up the navigation items when this controller is on top of the navigation stack
	[[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
	UIBarButtonItem *newButton = [[UIBarButtonItem alloc] 
								  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
	
	[[self navigationItem] setRightBarButtonItem:newButton];
	[newButton release];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Teams" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release]; 
	
	
    return self;
}

 // RKObjectLoaderDelegate methods  
   
 - (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {  
   [memberships removeAllObjects];
   for (Membership* member in objects) {
	  [memberships addObject:member];
	  [[self navigationItem] setTitle:[member fullName]];	
   }

   // make sure the view has the data 	 
   [[self tableView] reloadData];
}  
   
 - (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {  
   NSLog(@"Encountered an error: %@", error);
}	 

- (id) initWithStyle:(UITableViewStyle)style {
    return [self init];
}	

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [memberships count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
	MemberItemCell *cell = [[[MemberItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
												  reuseIdentifier:@"UITableViewCell"] autorelease];
	
	Membership *member = [memberships objectAtIndex:[indexPath row]];
	member.avatarImageName = @"icon.png";
	[cell setMembership:member];
	
	
	return cell;
}	

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    if (!teamMembersTableViewController) {
	     teamMembersTableViewController = [[TeamMembersTableViewController alloc]	init]; 
	}
	Membership *member = [memberships objectAtIndex:[indexPath row]];
	
	teamMembersTableViewController.teamID = [member teamID];	

	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:teamMembersTableViewController animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80; 
}

- (void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	RKObjectManager* manager = [RKObjectManager sharedManager];
	User *currentUser = [User currentUser];
	NSString *path = [NSString stringWithFormat:@"/users/%@/teams", [currentUser userID]];
    [manager loadObjectsAtResourcePath:path objectClass:[Membership class] delegate:self];
}	

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[memberships release];
	[teamMembersTableViewController release];
    [super dealloc];
}


@end
