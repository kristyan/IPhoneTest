//
//  TeamMembersTableViewController.m
//  TableTest
//
//  Created by kristyan connolly on 20/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "TeamMembersTableViewController.h"
#import "Member.h"


@implementation TeamMembersTableViewController

@synthesize teamID;

- (id) init {
	[super initWithStyle:UITableViewStyleGrouped]; //Grouped or plain style for table
	UIBarButtonItem *newButton = [[UIBarButtonItem alloc] 
	    initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];

	[[self navigationItem] setRightBarButtonItem:newButton];
	members  =[[NSMutableArray alloc] init];
	[newButton release];
	
    return self;
}

// RKObjectLoaderDelegate methods  

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {  
	[members removeAllObjects];
	for (Member* member in objects) {
		[members addObject:member];
		// set the navigation title
		[[self navigationItem] setTitle:[member teamName]];	
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
    return [members count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
	Member *member = [members objectAtIndex:[indexPath row]];
	
	cell.textLabel.text = [member fullName];
	cell.detailTextLabel.text = [member email];
	// Retreive the image from the webserver.
	// TODO - look into a better way of doing this, as this may not be optimal.
	NSURL *url = [NSURL URLWithString:[member fullAvatarThumbURL]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *img = [[UIImage alloc] initWithData:data];
	
	[cell.imageView setImage:img];
	
	return cell;
}	

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80; 
}

- (void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	RKObjectManager* manager = [RKObjectManager sharedManager];
	NSString *path = [NSString stringWithFormat:@"/teams/%@/members", teamID];
    [manager loadObjectsAtResourcePath:path objectClass:[Member class] delegate:self];
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

- (void)loadView

{
	[super loadView];
    [self buildTitleHeaderView:@"Team Members"];		
}

- (void)dealloc {
	[members release];
	[teamID release];
	[super dealloc];
}


@end

