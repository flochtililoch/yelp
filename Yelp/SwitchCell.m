//
//  SwitchCell.m
//  Yelp
//
//  Created by Florent Bonomo on 10/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SwitchCell.h"

@interface SwitchCell ()

// Outlets
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;

// Actions
- (IBAction)switchValueChanged:(id)sender;

@end

@implementation SwitchCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self.toggleSwitch setOn:on animated:animated];
}

- (IBAction)switchValueChanged:(id)sender {
    [self.delegate switchCell:self didUpdateValue:self.toggleSwitch.on];
}
@end
