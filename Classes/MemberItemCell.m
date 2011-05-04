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
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
	   imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
	   [[self contentView] addSubview:imageView];
	   [imageView setContentMode:UIViewContentModeScaleAspectFit];
	   [imageView release];
	   
	   teamNameLabel  =[[UILabel alloc] initWithFrame:CGRectZero]; 
	   [teamNameLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];

       [[self contentView] addSubview:teamNameLabel];
	   [teamNameLabel release];
	   
	   teamSportLocationLabel  =[[UILabel alloc] initWithFrame:CGRectZero]; 
       [[self contentView] addSubview:teamSportLocationLabel];
	   [teamSportLocationLabel release];
	   
	   organiserNameLabel  =[[UILabel alloc] initWithFrame:CGRectZero]; 
       [[self contentView] addSubview:organiserNameLabel];
	   [organiserNameLabel release];
   }
   return self;
}	

- (void) layoutSubviews {
    [super layoutSubviews];
	self.accessoryType	= UITableViewCellAccessoryDisclosureIndicator;
	
	float inset = 5;
	CGRect bounds = [[self contentView] bounds];
	float h = bounds.size.height;
	float w = bounds.size.width;
	
	// make the image square and equal to the height of the cell, minus the insets
    float imageSize = h - inset*2.0;
    float labelWidth = w - imageSize - inset;
	
	// 3 labels
	float labelHeight = (h -4.0*inset)/3.0;
	
	CGRect imageFrame = CGRectMake(inset, inset, imageSize, imageSize);
	[imageView setFrame:imageFrame];
	
	CGRect innerFrame = CGRectMake(imageSize + 2.0*inset, inset, labelWidth, labelHeight);
	[teamNameLabel setFrame:innerFrame];
	
	innerFrame.origin.y += labelHeight + inset;
	[teamSportLocationLabel setFrame:innerFrame];
	
	innerFrame.origin.y += labelHeight + inset;
	[organiserNameLabel setFrame:innerFrame];
}

- (void) setMembership:(Membership *) membership {
    [organiserNameLabel setText:[membership organiserName]];
	[teamNameLabel setText:[membership teamName]];
	NSString *teamSportLocation = [NSString stringWithFormat:@"%@%@%@", [membership teamSport], @" - ", [membership teamLocation]];
	[teamSportLocationLabel setText:teamSportLocation];
	UIImage* image = [UIImage imageNamed:[membership avatarImageName]];
	[imageView setImage:image];
}	

@end
