    //
//  MembershipsTableViewController.m
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "MembershipsTableViewController.h"
#import "Membership.h"
#import "MemberItemCell.h"


/**
 * The HTTP Header Field we transmit the authentication token obtained
 * during login/sign-up back to the server. This token is verified server
 * side to establish an authenticated session
 */
@implementation MembershipsTableViewController

- (id) init {
	[super initWithStyle:UITableViewStyleGrouped]; //Grouped or plain style for table
	
	memberships =[[NSMutableArray alloc] init];
	return self;
}

 // RKObjectLoaderDelegate methods  
   
 - (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {  
   for (Membership* member in objects) {
      NSLog(@"Loaded member %@", [member teamID]); 
	  [memberships addObject:member];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80; 
}

- (void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	RKObjectManager* manager = [RKObjectManager sharedManager];
    [manager loadObjectsAtResourcePath:@"/users/367/teams" objectClass:[Membership class] delegate:self];
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
    [super dealloc];
}


@end
