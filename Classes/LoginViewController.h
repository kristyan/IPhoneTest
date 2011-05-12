//
//  LoginViewController.h
//  TableTest
//
//  Created by kristyan connolly on 10/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface LoginViewController : UIViewController <UserAuthenticationDelegate> {
	IBOutlet UITextField *usernameField;
	IBOutlet UITextField *passwordField;
}

@property (nonatomic, retain) UITextField *usernameField;
@property (nonatomic, retain) UITextField *passwordField;

-(IBAction) loginClicked: (id) sender;
@end
