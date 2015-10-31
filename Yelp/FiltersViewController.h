//
//  FiltersViewController.h
//  Yelp
//
//  Created by Florent Bonomo on 10/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FiltersViewController *)filterViewController didChangeFilters:(NSArray *)filters;

@end

@interface FiltersViewController : UIViewController

@property (nonatomic, weak) id<FiltersViewControllerDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *filters;

@end
