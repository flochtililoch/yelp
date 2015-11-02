//
//  FilterOptionCell.m
//  Yelp
//
//  Created by Florent Bonomo on 11/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "FilterOptionCell.h"

@interface FilterOptionCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) BOOL on;

@end

@implementation FilterOptionCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setFilterOption:(FilterOption *)filterOption {
    self.titleLabel.text = filterOption.name;
    [self setOn:filterOption.selected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
