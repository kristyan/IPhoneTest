//
//  LoginViewController.m
//  TableTest
//
//  Created by kristyan connolly on 10/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"


@implementation LoginViewController
@synthesize usernameField;
@synthesize passwordField;
@synthesize statusLabel;

-(IBAction) loginClicked: (id) sender {
	// Log the user in
	User* user = [User currentUser];		
	[user loginWithUsername:usernameField.text andPassword:passwordField.text delegate:self];
}	

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

-  (void) viewDidLoad {
    [super viewDidLoad];
	[usernameField setDelegate:self];
	[passwordField setDelegate:self];
	
}	
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [usernameField release];
	usernameField = nil;
	[passwordField release];
	passwordField = nil;
	[statusLabel release];
	statusLabel = nil;
}


#pragma mark UserAuthenticationDelegate methods

- (void)userDidLogin:(User*)user {
	NSLog(@"Callback to userDidLogin");
	// dismiss the login screen
	[self dismissModalViewControllerAnimated:YES];
}

- (void)user:(User*)user didFailSignUpWithError:(NSError*)error {	
	//TTAlert([error localizedDescription]);
	[statusLabel setText:@"Connection Error"];
}

- (void)user:(User*)user didFailLoginWithConnectionError:(NSError*)error {
	NSLog(@"didFailLoginWithConnectionError  %@", error);
	[statusLabel setText:@"Connection Error"];
}


- (void)user:(User*)user didFailLoginWithStatusError:(NSString*)error andCode:(NSInteger)code {
   [statusLabel setText:error];
}	

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	// dismiss the text field keyboard when return is clciked
	[textField resignFirstResponder];
	return YES;
}


- (void)dealloc {
    [super dealloc];
	[usernameField release];
	[passwordField release];
	[statusLabel release];
}


@end
