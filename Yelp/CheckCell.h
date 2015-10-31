//
//  CheckCell.h
//  Yelp
//
//  Created by Florent Bonomo on 10/29/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckCell;

@protocol CheckCellDelegate <NSObject>

- (void)cellWasTapped:(CheckCell *)checkCell;

@end

@interface CheckCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) BOOL on;
@property (nonatomic, weak) id<CheckCellDelegate> delegate;

@end