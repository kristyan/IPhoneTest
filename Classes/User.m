//
//  User.m
//  TableTest
//
//  Created by kristyan connolly on 12/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "User.h"

// Constants
static NSString* const kDBUserCurrentUserIDDefaultsKey = @"kDBUserCurrentUserIDDefaultsKey";

// Notifications
NSString* const DBUserDidLoginNotification = @"DBUserDidLoginNotification";
NSString* const DBUserDidFailLoginNotification = @"DBUserDidFailLoginNotification";
NSString* const DBUserDidLogoutNotification = @"DBUserDidLogoutNotification";

// Current User singleton
static User* currentUser = nil;

@implementation User

@synthesize email;
@synthesize username;
@synthesize singleAccessToken;
@synthesize userID;

@synthesize delegate = _delegate;

/**
 * The property mapping dictionary. This method declares how elements in the JSON
 * are mapped to properties on the object
 */
+ (NSDictionary*)elementToPropertyMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"userID",
			@"email", @"email",
			@"single_access_token", @"singleAccessToken",
			nil];
}

/**
 * Informs RestKit which property contains the primary key for identifying
 * this object. This is used to ensure that existing objects are updated during mapping
 */
+ (NSString*)primaryKeyProperty {
	return @"userID";
}

/**
 * Returns the singleton current User instance. There is always a User returned so that you
 * are not sending messages to nil
 */
+ (User*)currentUser {
	if (nil == currentUser) {
		/*id userID = [[NSUserDefaults standardUserDefaults] objectForKey:kDBUserCurrentUserIDDefaultsKey];
		if (userID) {
			currentUser = [self objectWithPrimaryKeyValue:userID];
		} else {
			currentUser = [self object];
		}
		*/
		currentUser = [[User alloc] init];
    }
	
	return currentUser;
}

+ (void)setCurrentUser:(User*)user {
	[user retain];
	[currentUser release];
	currentUser = user;
}


/**
 * Implementation of a RESTful sign-up pattern. We are just relying on RestKit for
 * request/response processing and object mapping, but we have built a higher level
 * abstraction around Sign-Up as a concept and exposed notifications and delegate
 * methods that make it much more meaningful than a POST/parse/process cycle would be.
 */
- (void)signUpWithDelegate:(NSObject<UserAuthenticationDelegate>*)delegate {
	_delegate = delegate;
	[[RKObjectManager sharedManager] postObject:self delegate:self];
}

/**
 * Implementation of a RESTful login pattern. We construct an object loader addressed to
 * the /login resource path and POST the credentials. The target of the object loader is
 * set so that the login response gets mapped back into this object, populating the
 * properties according to the mappings declared in elementToPropertyMappings.
 */
- (void)loginWithUsername:(NSString*)user andPassword:(NSString*)pass delegate:(NSObject<UserAuthenticationDelegate>*)delegate {
	_delegate = delegate;
	
	RKObjectLoader* objectLoader = [[RKObjectManager sharedManager] objectLoaderWithResourcePath:@"/session.json" delegate:self];
	objectLoader.method = RKRequestMethodPOST;
	objectLoader.params = [NSDictionary dictionaryWithKeysAndObjects:@"email", user, @"password", pass, nil];	
	objectLoader.targetObject = self;
	[objectLoader send];
}

/**
 * Implementation of a RESTful logout pattern. We POST an object loader to
 * the /logout resource path. This destroys the remote session
 */
- (void)logout {	
	RKObjectLoader* objectLoader = [[RKObjectManager sharedManager] objectLoaderWithResourcePath:@"/session" delegate:self];
	objectLoader.method = RKRequestMethodDELETE;
	objectLoader.targetObject = self;
	[objectLoader send];
}

- (void)loginWasSuccessful {
	// Upon login, we become the current user
	[User setCurrentUser:self];
	
	// Persist the UserID for recovery later
	[[NSUserDefaults standardUserDefaults] setObject:self.userID forKey:kDBUserCurrentUserIDDefaultsKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	// Inform the delegate
	if ([self.delegate respondsToSelector:@selector(userDidLogin:)]) {
		[self.delegate userDidLogin:self];
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:DBUserDidLoginNotification object:self];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray *)objects {
	// NOTE: We don't need objects because self is the target of the mapping operation
	
	if ([objectLoader isPOST]) {
		// Login was successful
		[self loginWasSuccessful];
	} else if ([objectLoader isDELETE]) {
		// Logout was successful
		
		// Clear the stored credentials
		[[NSUserDefaults standardUserDefaults] setValue:nil forKey:kDBUserCurrentUserIDDefaultsKey];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		// Inform the delegate
		if ([self.delegate respondsToSelector:@selector(userDidLogout:)]) {
			[self.delegate userDidLogout:self];
		}
		
		[[NSNotificationCenter defaultCenter] postNotificationName:DBUserDidLogoutNotification object:nil];
	}
}

// This Appears to be called when we have a connection error
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError*)error {	
	if ([objectLoader isPOST]) {
		// Login failed
		if ([self.delegate respondsToSelector:@selector(user:didFailLoginWithConnectionError:)]) {
			[self.delegate user:self didFailLoginWithConnectionError:error];
		}
	} 
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader {
    NSInteger statusCode = [[objectLoader response] statusCode];
	NSString *error = [[objectLoader response ] bodyAsString]; 
	if (statusCode == 400) {
		if ([self.delegate respondsToSelector:@selector(user:didFailLoginWithStatusError:andCode:)]) {
			[self.delegate user:self didFailLoginWithStatusError:error andCode:statusCode];
		}
	}
}	

- (BOOL)isLoggedIn {
	return self.singleAccessToken != nil;
}


- (void)dealloc {
	_delegate = nil;
	[super dealloc];
}

@end
