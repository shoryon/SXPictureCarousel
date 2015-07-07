//
//  UIImageView+Extension.h
//  PictureCarousel
//
//  Created by 沧海小鱼 on 15/4/20.
//  Copyright (c) 2015年 Coder Shoryon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;

@end
