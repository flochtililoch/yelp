//
//  Filter.h
//  Yelp
//
//  Created by Florent Bonomo on 10/29/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filter : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *options;

- (instancetype)initWithDictionary:(NSDictionary *)definition;
- (void)toggleOptionAtIndex:(NSInteger)index;
- (void)resetSelectionWithOptionAtIndex:(NSInteger)index;
- (NSArray *)selectedOptions;

@end
