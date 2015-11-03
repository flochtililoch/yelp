//
//  YelpClient.h
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBOAuth1RequestOperationManager.h"
#import "YelpBusiness.h"
#import "YelpFilters.h"

@interface YelpClient : BDBOAuth1RequestOperationManager

+ (instancetype)sharedInstance;

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term
                                completion:(void (^)(NSArray *businesses, NSInteger totalCount, NSError *error))completion;

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term
                                   filters:(NSArray *)filters
                                    offset:(NSInteger)offset
                                completion:(void (^)(NSArray *businesses, NSInteger totalCount, NSError *error))completion;

@end
