//
//  MemberProfileTableViewController.m
//  TableTest
//
//  Created by kristyan connolly on 10/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "MemberProfileTableViewController.h"
#import "User.h"


@implementation MemberProfileTableViewController


#pragma mark -
#pragma mark Initialization

- (id) init {
	[super initWithStyle:UITableViewStyleGrouped]; //Grouped or plain style for table
	[[self navigationItem] setRightBarButtonItem:[self editButtonItem]];
	memberData = [[NSMutableDictionary alloc] init];
	memberDataLabels = [[NSMutableArray alloc] init];
	fullName = [[NSString alloc] init];
	
	return self;
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	// setup data
    User* user = [User currentUser];
	[memberDataLabels addObject:@"Email"]; 
	[memberData setObject:[user email] forKey:@"Email"];
	[memberDataLabels addObject:@"Phone"]; 
	[memberData setObject:[user phone] forKey:@"Phone"];
    [memberDataLabels addObject:@"Location"]; 
	[memberData setObject:[user city] forKey:@"Location"];
	NSString* gender = [user gender];
	if (!gender) {
		gender = @"Unknown";
	}
	[memberDataLabels addObject:@"Gender"]; 
	[memberData setObject:gender forKey:@"Gender"];
	
	[memberDataLabels addObject:@"Teams"];
	[memberDataLabels addObject:@"Siblings"];
	
	fullName = [NSString stringWithFormat:@"%@%@%@", [user firstName], @" ", [user lastName]];
	NSString *navTitle = fullName;
	
	// set the navigation title
	[[self navigationItem] setTitle:navTitle];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
		return 1;
	}
	else {
	    return [memberDataLabels count];
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *Section1Cell = @"Section1Cell";
    static NSString *Section2Cell = @"Section2Cell";
    
    UITableViewCell *cell = nil;    
    
	if (indexPath.section == 1) {
		
		NSString* label = [memberDataLabels objectAtIndex:[indexPath row]];
		cell = [tableView dequeueReusableCellWithIdentifier:Section1Cell];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Section1Cell] autorelease];
		}
		
		// these cells have accessory types
		if ([label isEqualToString:@"Teams"] || [label isEqualToString:@"Siblings"]) {
		    cell.textLabel.text = label;
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } // normal cell
		else {
		    cell.textLabel.text = label;
			cell.detailTextLabel.text = [memberData objectForKey:label];
		}	
	}
	else {
		cell = [tableView dequeueReusableCellWithIdentifier:Section2Cell];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Section2Cell] autorelease];
		}
		
	    cell.textLabel.text = fullName;
		cell.image = [UIImage imageNamed:@"icon.png"];
	}	
	return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString* label = [memberDataLabels objectAtIndex:[indexPath row]];
	if ([label isEqualToString:@"Teams"]) {
		// select the teams tab
	    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
	}
}


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


- (void)dealloc {
    [super dealloc];
}


@end

