//
//  NavigationViewController.m
//  Yelp
//
//  Created by Florent Bonomo on 11/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.80 green:0.08 blue:0.02 alpha:1.0];
    self.navigationBar.translucent = NO;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
