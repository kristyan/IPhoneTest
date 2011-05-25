//
//  MemberItemCell.m
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "MemberItemCell.h"
#import "Membership.h"


@implementation MemberItemCell

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier {
	[super initWithRowCount:3 reuseIdentifier:reuseIdentifier];
	return self;
}	

- (void) setDataFromModel:(BaseModel*) model {
	Membership* membership = (Membership*)model;
	if ( [labels count] != 3 ) {
		return;
	}
    [[labels objectAtIndex:0] setText:[membership organiserName]];
	[[labels objectAtIndex:1] setText:[membership teamName]];
	NSString *teamSportLocation = [NSString stringWithFormat:@"%@%@%@", [membership teamSport], @" - ", [membership teamLocation]];
	[[labels objectAtIndex:2] setText:teamSportLocation];
	
	// Retrieve the image from the webserver.
	// TODO - look into a better way of doing this, as this may not be optimal.
	NSURL *url = [NSURL URLWithString:[membership fullAvatarThumbURL]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *img = [[UIImage alloc] initWithData:data];
	
	[imageView setImage:img];
	[img release];
}	

@end
