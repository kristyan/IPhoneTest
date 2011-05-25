//
//  ThreeRowItemCell.h
//  TableTest
//
//  Created by kristyan connolly on 24/05/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseModel;

/**
 * A Table Cell View that has an image and multiple rows of data.
 */
@interface MultiRowItemCell : UITableViewCell {
    UIImageView *imageView;
	// UILabels used to store each row of data
	NSMutableArray* labels;
}

- (id)initWithRowCount:(NSUInteger)rowCount
	   reuseIdentifier:(NSString*)reuseIdentifier;

/**
 * Subclasses should override to set up cell data.
 */
- (void)setDataFromModel:(BaseModel*) model;

@end
