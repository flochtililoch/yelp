//
//  YelpFilters.h
//  Yelp
//
//  Created by Florent Bonomo on 10/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpFilters : NSObject <NSCopying>

typedef NS_ENUM(NSInteger, YelpSortMode) {
    YelpSortModeBestMatched = 0,
    YelpSortModeDistance = 1,
    YelpSortModeHighestRated = 2
};

@property (nonatomic, assign) YelpSortMode sortMode;
@property (nonatomic, assign) BOOL hasDeals;
@property (nonatomic, strong) NSMutableSet *selectedCategories;

+ (NSArray *)categories;
    
@end
