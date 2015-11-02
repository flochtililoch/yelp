//
//  CheckCell.h
//  Yelp
//
//  Created by Florent Bonomo on 10/29/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterOptionCell.h"

@class CheckCell;

@protocol CheckCellDelegate <NSObject>

- (void)cellWasTapped:(CheckCell *)checkCell;

@end

@interface CheckCell : FilterOptionCell

@property (nonatomic, weak) id<CheckCellDelegate> delegate;

@end