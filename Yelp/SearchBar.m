//
//  SearchBar.m
//  Yelp
//
//  Created by Florent Bonomo on 10/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setPlaceholder:@"Search..."];
        
//        [self setTintColor:[UIColor redColor]];
//        UITextField *textField = [UITextField appearanceWhenContainedIn:[UISearchBar class], nil];
//        
//        [textField setBackgroundColor:[UIColor colorWithRed:0.67 green:0.07 blue:0.01 alpha:1.0]];
//        [textField setTextColor:[UIColor whiteColor]];
//        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search..." attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:0.89 green:0.64 blue:0.62 alpha:1.0] }];

    }
    return self;
}

@end
