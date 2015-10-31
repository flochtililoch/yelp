//
//  Filter.m
//  Yelp
//
//  Created by Florent Bonomo on 10/29/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "Filter.h"
#import "FilterOption.h"

@implementation Filter

- (instancetype)initWithDictionary:(NSDictionary *)definition {
    if (self = [super init]) {
        self.identifier = definition[@"id"];
        self.title = definition[@"title"];
        
        NSMutableArray *options = [NSMutableArray array];
        for (NSDictionary *option in  definition[@"options"]) {
            [options addObject:[[FilterOption alloc] initWithDictionary:option]];
        }
        self.options = options;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    Filter *copy = [[[self class] allocWithZone:zone] init];
    if (copy) {
        copy.identifier = self.identifier;
        copy.title = self.title;
        copy.options = self.options;
    }
    return copy;
}

- (NSArray *)selectedOptions {
    NSMutableArray *options = [NSMutableArray array];
    for (FilterOption *option in self.options) {
        if (option.selected) {
            [options addObject:option];
        }
    }
    return options;
}

- (void)toggleOptionAtIndex:(NSInteger)index {
    FilterOption *option = [self.options objectAtIndex:index];
    option.selected = !option.selected;
}

- (void)resetSelectionWithOptionAtIndex:(NSInteger)index {
    for (FilterOption *option in self.options) {
        option.selected = NO;
    }
    FilterOption *option = [self.options objectAtIndex:index];
    option.selected = YES;
}

@end
