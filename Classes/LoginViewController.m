//
//  LoginViewController.m
//  TableTest
//
//  Created by kristyan connolly on 10/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "LoginViewController.h"
#import "User.h"

@implementation LoginViewController

@synthesize usernameField;
@synthesize passwordField;
@synthesize logoImage;

- (id)init {
	self = [super initWithNibName:@"LoginView" bundle:nil];
	return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
	// Give the logo image rounded corners
	logoImage.layer.cornerRadius = 5.0;
	logoImage.layer.masksToBounds = YES;
}	

-  (void)viewDidLoad {
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
	[logoImage release];
	logoImage = nil;
}

#pragma mark UserAuthenticationDelegate methods

- (void)userDidLogin:(User*)user {
	// dismiss the login screen
	[self dismissModalViewControllerAnimated:YES];
}

- (void)user:(User*)user didFailSignUpWithError:(NSError*)error {	
	[self showErrorAlert:@"Connection Error"];
}

- (void)user:(User*)user didFailLoginWithConnectionError:(NSError*)error {
	[self showErrorAlert:@"Connection Error"];
}

- (void)user:(User*)user didFailLoginWithStatusError:(NSString*)error 
											 andCode:(NSInteger)code {
	[self showErrorAlert:error];
}	


#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
	// Log the user in
	User* user = [User currentUser];
	[user loginWithUsername:usernameField.text andPassword:passwordField.text delegate:self];
	// dismiss the text field keyboard when return is clicked
	[textField resignFirstResponder];
	return YES;
}

- (void)showErrorAlert:(NSString*)errorMsg {
	UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:@"Error"];
	[alert setMessage:errorMsg];
	[alert setDelegate:nil];
	[alert addButtonWithTitle:@"Ok"];
	[alert show];
	[alert release];
}

- (void)dealloc {
    [super dealloc];
	[usernameField release];
	[passwordField release];
	[logoImage release];
}

@end
