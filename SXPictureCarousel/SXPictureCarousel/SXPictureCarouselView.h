//
//  PictureCarouselView.h
//  PictureCarousel
//
//  Created by 沧海小鱼 on 15/4/17.
//  Copyright (c) 2015年 Coder Shoryon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXPictureCarousel.h"

@class SXPictureCarouselView;

@protocol SXPictureCarouselViewDelegate <NSObject>

@optional
- (void)pictureCarouselView:(SXPictureCarouselView *)pictureCarouselView didClickedItem:(SXPictureCarousel *)item;

@end

@interface SXPictureCarouselView : UIView

@property (nonatomic, strong) id package;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) NSTimeInterval scrollTimeInterval;
@property (nonatomic, assign) UIEdgeInsets imageEdgeInsets;
@property (nonatomic, assign) id<SXPictureCarouselViewDelegate> delegate;

@end
