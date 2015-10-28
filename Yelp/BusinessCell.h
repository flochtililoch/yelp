//
//  BusinessCell.h
//  Yelp
//
//  Created by Florent Bonomo on 10/27/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpBusiness.h"

@interface BusinessCell : UITableViewCell

@property (strong, nonatomic) YelpBusiness *business;

@end
