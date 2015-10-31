//
//  FilterOption.m
//  Yelp
//
//  Created by Florent Bonomo on 10/30/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "FilterOption.h"

@implementation FilterOption

- (instancetype)initWithDictionary:(NSDictionary *)definition {
    if (self = [super init]) {
        self.name = definition[@"name"];
        self.code = definition[@"code"];
        self.selected = [definition[@"selected"] boolValue];
    }
    return self;
}

@end
