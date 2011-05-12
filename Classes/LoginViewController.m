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

-(IBAction) loginClicked: (id) sender {
	NSLog(@"email = %@", usernameField.text);
	NSLog(@"password = %@", passwordField.text);
    
	// Login
	User* user = [User currentUser];		
	[user loginWithUsername:usernameField.text andPassword:passwordField.text delegate:self];
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


#pragma mark UserAuthenticationDelegate methods

- (void)userDidLogin:(User*)user {
	NSLog(@"Callback to userDidLogin");
	// dismiss the login screen
	[self dismissModalViewControllerAnimated:YES];
}

- (void)user:(User*)user didFailSignUpWithError:(NSError*)error {	
	//TTAlert([error localizedDescription]);
	NSLog(@"Callback to didFailSignUpWithError");
}

- (void)user:(User*)user didFailLoginWithError:(NSError*)error {
	NSLog(@"Callback to didFailLoginWithError");
	/*[[[[UIAlertView alloc] initWithTitle:@"Error"
								 message:[error localizedDescription]
								delegate:nil
					   cancelButtonTitle:@"OK"
					   otherButtonTitles:nil] autorelease] show];*/
}

- (void)dealloc {
    [super dealloc];
}


@end
