//
//  UIImageView+Extension.m
//  PictureCarousel
//
//  Created by 沧海小鱼 on 15/4/20.
//  Copyright (c) 2015年 Coder Shoryon. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"

/**
 *  默认占位图片
 */
#define kPlaceholderImage [UIImage imageNamed:@"PlaceholderImage"]

@implementation UIImageView (Extension)

- (void)setImageWithURL:(NSURL *)url {
    
    [self setImageWithURL:url placeholderImage:kPlaceholderImage];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage {
    
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageRetryFailed|SDWebImageLowPriority];
}

@end
