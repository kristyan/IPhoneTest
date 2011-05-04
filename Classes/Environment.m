//
//  Environment.m
//  Teamer
//
//  Created by Anthony Garcia on 1/7/11.
//  Copyright 2011 Teamer. All rights reserved.
//

#import "Environment.h"

// Base URL
#if ENVIRONMENT == ENVIRONMENT_DEVELOPMENT
NSString* const DBRestKitBaseURL = @"http://localhost:3000";
#elif ENVIRONMENT == ENVIRONMENT_STAGING
NSString* const DBRestKitBaseURL = @"http://app01.c45063.blueboxgrid.com";
#elif ENVIRONMENT == ENVIRONMENT_PRODUCTION
NSString* const DBRestKitBaseURL = @"http://teamer.net";
#endif

