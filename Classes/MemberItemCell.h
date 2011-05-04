//
//  MemberItemCell.h
//  TableTest
//
//  Created by kristyan connolly on 28/04/2011.
//  Copyright 2011 teamer.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Membership;

@interface MemberItemCell : UITableViewCell {
	UIImageView *imageView; 
	UILabel *teamNameLabel;
	UILabel *teamSportLocationLabel;
    UILabel *organiserNameLabel;
}

- (void) setMembership:(Membership *) membership;
@end
