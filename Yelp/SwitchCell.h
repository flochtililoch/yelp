//
//  SwitchCell.h
//  Yelp
//
//  Created by Florent Bonomo on 10/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterOptionCell.h"

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

- (void)switchCell:(SwitchCell *)switchCell didUpdateValue:(BOOL)value;

@end

@interface SwitchCell : FilterOptionCell

@property (nonatomic, weak) id<SwitchCellDelegate> delegate;

@end
