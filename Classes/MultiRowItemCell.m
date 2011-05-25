//
//  ThreeRowItemCell.m
//  TableTest
//
//  Created by kristyan connolly on 24/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import "MultiRowItemCell.h"

@implementation MultiRowItemCell

- (id) initWithRowCount:(NSUInteger)rowCount reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
		
		labels = [[NSMutableArray alloc] initWithCapacity:rowCount];
		
		// setup the image view
		imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[[self contentView] addSubview:imageView];
		[imageView setContentMode:UIViewContentModeScaleAspectFit];
		[imageView release];
		
		// set up labels
		for (int i = 0; i < rowCount; i++) {
		    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
			[labels addObject:label];
			[[self contentView] addSubview:label];
			[label release];
        }
	}
	return self;
}	
	
- (void) layoutSubviews {
    [super layoutSubviews];
	self.accessoryType	= UITableViewCellAccessoryDisclosureIndicator;
	
	float labelsCount = [labels count];
	if (labelsCount < 1) {
		return;
	}
	
	float inset = 5;
	CGRect bounds = [[self contentView] bounds];
	float h = bounds.size.height;
	float w = bounds.size.width;
	
	// make the image square and equal to the height of the cell, minus the insets
    float imageSize = h - inset*2.0;
    float labelWidth = w - imageSize - inset;
	
	float labelHeight = (h -(labelsCount+1.0)*inset)/labelsCount;
	
	CGRect imageFrame = CGRectMake(inset, inset, imageSize, imageSize);
	[imageView setFrame:imageFrame];
	
	CGRect innerFrame = CGRectMake(imageSize + 2.0*inset, inset, labelWidth, labelHeight);
	[[labels objectAtIndex:0] setFrame:innerFrame];
	
	for (int i = 1; i < [labels count]; i++) {
		innerFrame.origin.y += labelHeight + inset;
		[[labels objectAtIndex:i] setFrame:innerFrame];
	}
}

- (void) setDataFromModel:(BaseModel*) model {
}	

- (void) dealloc {
	[super dealloc];
    [labels release];
}	

@end
