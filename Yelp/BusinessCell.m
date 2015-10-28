//
//  BusinessCell.m
//  Yelp
//
//  Created by Florent Bonomo on 10/27/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "BusinessCell.h"
#import "UIImageView+FadeIn.h"

@interface BusinessCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@end

@implementation BusinessCell

- (void)awakeFromNib {
    self.thumbImageView.layer.cornerRadius = 5;
    self.thumbImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBusiness:(YelpBusiness *)business {
    _business = business;
    
    [self.thumbImageView fadeInImageView:self.thumbImageView url:self.business.imageUrl errorImage:nil placeholderImage:nil];
    self.nameLabel.text = self.business.name;
    [self.ratingImageView fadeInImageView:self.ratingImageView url:self.business.ratingImageUrl errorImage:nil placeholderImage:nil];
    self.ratingLabel.text = [NSString stringWithFormat:@"%@ Reviews", self.business.reviewCount];
    self.addressLabel.text = self.business.address;
    self.distanceLabel.text = self.business.distance;
    self.categoryLabel.text = self.business.categories;
}

@end
