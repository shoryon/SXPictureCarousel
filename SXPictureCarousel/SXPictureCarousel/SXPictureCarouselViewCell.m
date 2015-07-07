//
//  PictureCarouselViewCell.m
//  PictureCarousel
//
//  Created by 沧海小鱼 on 15/4/17.
//  Copyright (c) 2015年 Coder Shoryon. All rights reserved.
//

#import "SXPictureCarouselViewCell.h"
#import "SXPictureCarousel.h"
#import "UIImageView+Extension.h"

/**
 *  对象是否为空
 */
#define IsNilOrNull(_ref) (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

@interface SXPictureCarouselViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@end

@implementation SXPictureCarouselViewCell

- (void)setPictureCarousel:(SXPictureCarousel *)pictureCarousel {
    
    _pictureCarousel = pictureCarousel;
    
    switch (self.pictureCarousel.requestType) {
        case SXPictureCarouselRequestTypeLocal:
            if (!IsNilOrNull(self.pictureCarousel.imageName)) {
                self.pictureView.image = [UIImage imageNamed:self.pictureCarousel.imageName];
            }
            break;
        case SXPictureCarouselRequestTypeUrl:
            if (!IsNilOrNull(self.pictureCarousel.requestUrl)) {
                [self.pictureView setImageWithURL:[NSURL URLWithString:self.pictureCarousel.requestUrl]];
            }
            break;
        default:
            break;
    }
}

@end
