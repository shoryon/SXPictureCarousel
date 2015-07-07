//
//  PictureCarouselEntity.m
//  PictureCarousel
//
//  Created by 沧海小鱼 on 15/4/17.
//  Copyright (c) 2015年 Coder Shoryon. All rights reserved.
//

#import "SXPictureCarousel.h"

@implementation SXPictureCarousel

- (instancetype)initWithImageName:(NSString *)imageName {
    return [self initWithTitleName:nil imageName:imageName];
}

+ (instancetype)initWithImageName:(NSString *)imageName {
    return [self initWithTitleName:nil imageName:imageName];
}

- (instancetype)initWithRequestUrl:(NSString *)requestUrl {
    return [self initWithTitleName:nil requestUrl:requestUrl];
}

+ (instancetype)initWithRequestUrl:(NSString *)requestUrl {
    return [self initWithTitleName:nil requestUrl:requestUrl];
}

- (instancetype)initWithTitleName:(NSString *)titleName imageName:(NSString *)imageName {
    if (self = [super init]) {
        self.titleName = titleName;
        self.imageName = imageName;
        self.requestType = SXPictureCarouselRequestTypeLocal;
    }
    return self;
}

+ (instancetype)initWithTitleName:(NSString *)titleName imageName:(NSString *)imageName {
    return [[self alloc] initWithTitleName:titleName imageName:imageName];
}

- (instancetype)initWithTitleName:(NSString *)titleName requestUrl:(NSString *)requestUrl {
    if (self = [super init]) {
        self.titleName = titleName;
        self.requestUrl = requestUrl;
        self.requestType = SXPictureCarouselRequestTypeUrl;
    }
    return self;
}

+ (instancetype)initWithTitleName:(NSString *)titleName requestUrl:(NSString *)requestUrl {
    return [[self alloc] initWithTitleName:titleName requestUrl:requestUrl];
}

@end
