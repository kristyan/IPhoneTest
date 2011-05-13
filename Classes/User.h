//
//  User.h
//  TableTest
//
//  Created by kristyan connolly on 12/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>


@protocol UserAuthenticationDelegate;

////////////////////////////////////////////////////////////////////////////////////////////////

@interface User : RKObject <RKObjectLoaderDelegate> {
	NSObject<UserAuthenticationDelegate>* _delegate;
}

/**
 * The delegate for the User. Will be informed of session life-cycle events
 */
@property (nonatomic, assign) NSObject<UserAuthenticationDelegate>* delegate;

/**
 * The e-mail address of the User
 */
@property (nonatomic, retain) NSString* email;

/**
 * The username of the User
 */
@property (nonatomic, retain) NSString* username;

/**
 * An Access Token returned when a User is authenticated
 */
@property (nonatomic, retain) NSString* singleAccessToken;

/**
 * The numeric primary key of this User in the remote backend system
 */
@property (nonatomic, retain) NSNumber* userID;



////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * A globally available singleton reference to the current User. When the User is
 * not authenticated, a new object will be constructed and returned
 */
+ (User*)currentUser;

/**
 * Completes a sign up using the properties assigned to the object
 */
- (void)signUpWithDelegate:(NSObject<UserAuthenticationDelegate>*)delegate;

/**
 * Attempts to log a User into the system with a given username and password
 */
- (void)loginWithUsername:(NSString*)username andPassword:(NSString*)password delegate:(NSObject<UserAuthenticationDelegate>*)delegate;

/**
 * Returns YES when the User is logged in
 */
- (BOOL)isLoggedIn;

/**
 * Logs the User out of the system
 */
- (void)logout;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Notifications
 */
extern NSString* const UserDidLoginNotification; // Posted when the User logs in
extern NSString* const UserDidLogoutNotification; // Posted when the User logs out

/**
 * A protocol defining life-cycles events for a user logging in and out
 * of the application
 */
@protocol UserAuthenticationDelegate

@optional

/**
 * Sent to the delegate when sign up has completed successfully. Immediately
 * followed by an invocation of userDidLogin:
 */
- (void)userDidSignUp:(User*)user;

/**
 * Sent to the delegate when sign up failed for a specific reason
 */
- (void)user:(User*)user didFailSignUpWithError:(NSError*)error;

/**
 * Sent to the delegate when the User has successfully authenticated
 */
- (void)userDidLogin:(User*)user;

/**
 * Sent to the delegate when the User failed login due to connection problems
 */
- (void)user:(User*)user didFailLoginWithConnectionError:(NSError*)error;

/**
 * Sent to the delegate when the User failed login for a specific reason
 */
- (void)user:(User*)user didFailLoginWithStatusError:(NSString*)error andCode:(NSInteger)code;

/**
 * Sent to the delegate when the User logged out of the system
 */
- (void)userDidLogout:(User*)user;

@end
