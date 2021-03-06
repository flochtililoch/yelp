//
//  YelpClient.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpClient.h"
#import "Filter.h"
#import "FilterOption.h"

// You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface YelpClient ()

@end

@implementation YelpClient

// Singleton
+ (instancetype)sharedInstance {
    static YelpClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YelpClient alloc] init];
    });
    return instance;
}

- (instancetype)init {
    NSURL *baseURL = [NSURL URLWithString:@"https://api.yelp.com/v2/"];
    if (self = [super initWithBaseURL:baseURL consumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret]) {
        
        BDBOAuth1Credential *token = [BDBOAuth1Credential credentialWithToken:kYelpToken
                                                                       secret:kYelpTokenSecret
                                                                   expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term
                                completion:(void (^)(NSArray *businesses, NSInteger totalCount, NSError *error))completion {
    
    return [self searchWithTerm:term
                        filters:nil
                         offset:0
                     completion:completion];
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term
                                   filters:(NSArray *)filters
                                    offset:(NSInteger)offset
                                completion:(void (^)(NSArray *businesses, NSInteger totalCount, NSError *error))completion {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSMutableDictionary *parameters = [@{@"term": term,
                                         @"ll" : @"37.774866,-122.394556",
                                         @"sort": @(0)}
                                       mutableCopy];
    
    if (offset) {
        parameters[@"offset"] = [NSString stringWithFormat:@"%lu", (unsigned long)offset];
    }
    
    // Dynamically generate API parameters based on filters
    for (Filter *filter in filters) {
        if ([filter selectedOptions].count) {
            NSString *value = [[[filter selectedOptions] valueForKey:@"code"] componentsJoinedByString:@","];
            if (value.length > 0) {
                parameters[filter.identifier] = value;
            }
        }
    }
    
    NSLog(@"%@", parameters);
    
    return [self GET:@"search"
          parameters:parameters
             success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                 
                 NSArray *businesses = responseObject[@"businesses"];
                 NSInteger totalCount = [responseObject[@"total"] intValue];
                 completion([YelpBusiness businessesFromJsonArray:businesses], totalCount, nil);
                 
             } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                 completion(nil, 0, error);
             }];
}

@end
