//
//  CheckCell.m
//  Yelp
//
//  Created by Florent Bonomo on 10/29/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "CheckCell.h"

@interface CheckCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) BOOL on;

@end

@implementation CheckCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {
        [self.delegate cellWasTapped:self];
    }
}

- (void)setOn:(BOOL)on {
    _on = on;
    self.accessoryType = on ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
