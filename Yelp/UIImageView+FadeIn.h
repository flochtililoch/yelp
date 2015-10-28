//
//  UIImageView+FadeIn.h
//  Yelp
//
//  Created by Florent Bonomo on 10/27/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface UIImageView (FadeIn)

- (void)fadeInImageView:(UIImageView *)imageView
                    url:(NSURL *)url
             errorImage:(UIImage *)errorImage
       placeholderImage:(UIImage *)placeholderImage;


@end
