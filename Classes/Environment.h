//
//  DBEnvironment.h
//  Teamer
//
//  Created by Anthony Garcia on 1/7/11.
//  Copyright 2011 Teamer. All rights reserved.
//

/**
 * The Base URL constant. This Base URL is used to initialize RestKit via RKClient
 * or RKObjectManager (which in turn initializes an instance of RKClient). The Base
 * URL is used to build full URL's by appending a resource path onto the end.
 *
 * By abstracting your Base URL into an externally defined constant and utilizing
 * conditional compilation, you can very quickly switch between server environments
 * and produce builds targetted at different backend systems.
 */
extern NSString* const DBRestKitBaseURL;

/**
 * Server Environments for conditional compilation
 */
#define ENVIRONMENT_DEVELOPMENT 0
#define ENVIRONMENT_STAGING 1
#define ENVIRONMENT_PRODUCTION 2

// Use Development by default
#ifndef ENVIRONMENT
#define ENVIRONMENT ENVIRONMENT_DEVELOPMENT
#endif
