//
//  TableTestAppDelegate.m
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "TableTestAppDelegate.h"

// RestKit
#import <RestKit/RestKit.h>
#import <RestKit/ObjectMapping/RKDynamicRouter.h>
#import <RestKit/ObjectMapping/RKRailsRouter.h>

// Teamer
#import "Environment.h"
#import "Membership.h"
#import	"User.h"
#import "MembershipsTableViewController.h"
#import "MemberProfileTableViewController.h"
#import "LoginViewController.h"

@implementation TableTestAppDelegate

@synthesize window;

static NSString* const AccessTokenHTTPHeaderField = @"X-USER-ACCESS-TOKEN";

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:TeamerBaseURL]; 
	
	// Set nil for any attributes we expect to appear in the payload, but do not
	objectManager.mapper.missingElementMappingPolicy = RKSetNilForMissingElementMappingPolicy;

	//[objectManager.client setValue:@"vIMHjQcmj03GFMrfZe2X" forHTTPHeaderField:accessTokenHTTPHeaderField];
	// Initialize object store
	// We are using the Core Data support, so we have initialized a managed object store backed
	// with a SQLite database. We are also utilizing the managed object cache support to provide
	// offline access to locally cached content.
	objectManager.objectStore = [[[RKManagedObjectStore alloc] initWithStoreFilename:@"Teamer.sqlite"] autorelease];
	//objectManager.objectStore.managedObjectCache = [[DBManagedObjectCache new] autorelease];
	
	//[objectManager registerClass:[User class] forElementNamed:@"user"];
	
	// Set Up Router
	// The router is responsible for generating the appropriate resource path to
	// GET/POST/PUT/DELETE an object representation. This prevents your code from
	// becoming littered with identical resource paths as you manipulate common 
	// objects across your application. Note that a single object representation
	// can be loaded from any number of resource paths. You can also PUT/POST
	// an object to arbitrary paths by configuring the object loader yourself. The
	// router is just for configuring the default 'home address' for an object.
	//
	// Since we are communicating with a Ruby on Rails backend server, we are using
	// the Rails router. The Rails router is aware of the Rails pattern of nesting
	// attributes under the underscored version of the model name. The Rails router
	// will also not send any attributes in a DELETE request, preventing problems with
	// forgery protection.
	RKRailsRouter* router = [[[RKRailsRouter alloc] init] autorelease];
	
	[router setModelName:@"membership" forClass:[Membership class]];
	[router routeClass:[Membership class] toResourcePath:@"/users/(userID)/teams" forMethod:RKRequestMethodGET];
		
	objectManager.router = router;
	
    // Register for authentication notifications
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAccessTokenHeaderFromAuthenticationNotification:) name:UserDidLoginNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAccessTokenHeaderFromAuthenticationNotification:) name:UserDidLogoutNotification object:nil];
	
	// Initialize authenticated access if we have a logged in current User reference
	User* user = [User currentUser];
	if ([user isLoggedIn]) {
	    [objectManager.client setValue:user.singleAccessToken forHTTPHeaderField:AccessTokenHTTPHeaderField];
	}
	
	
	// configure controllers
	UITabBarController *tabBarController = [[UITabBarController alloc] init];
	
	membershipsViewController = [[MembershipsTableViewController alloc] init];
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:membershipsViewController];
	
	MemberProfileTableViewController* memberProfileTableViewController = [[MemberProfileTableViewController alloc] init];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:navController, memberProfileTableViewController, nil];
	[navController release];
	[memberProfileTableViewController release];
	
	[tabBarController setViewControllers:viewControllers];
	
	[window setRootViewController:tabBarController];
	
	[tabBarController release];
	
	[self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


// Watch for login/logout events and set the Access Token HTTP Header
- (void)setAccessTokenHeaderFromAuthenticationNotification:(NSNotification*)notification {
	User* user = (User*) [notification object];
	RKObjectManager* objectManager = [RKObjectManager sharedManager];
	[objectManager.client setValue:user.singleAccessToken forHTTPHeaderField:AccessTokenHTTPHeaderField];
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [window release];
	[membershipsViewController release];
    [super dealloc];
}


@end
