//
//  FilterOption.h
//  Yelp
//
//  Created by Florent Bonomo on 10/30/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterOption : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithDictionary:(NSDictionary *)definition;

@end
