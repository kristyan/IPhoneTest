//
//  BaseModel.m
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//


#import "BaseModel.h"

NSString* const BaseModelDidChangeNotification = @"BaseModelDidChangeNotification";

@implementation BaseModel

@synthesize createdAt;
@synthesize updatedAt;

/**
 * Instructs RestKit to map nested objects to the Core Data
 * relationship specified
 */
//+ (NSDictionary*)elementToRelationshipMappings {
//	return [NSDictionary dictionaryWithObject:@"user" forKey:@"user"];
//}

- (BOOL)isNewRecord {
	return [[self primaryKeyValue] intValue] == 0;
}

@end
