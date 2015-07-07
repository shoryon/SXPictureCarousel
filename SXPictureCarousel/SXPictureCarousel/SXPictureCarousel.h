//
//  PictureCarouselEntity.h
//  PictureCarousel
//
//  Created by 沧海小鱼 on 15/4/17.
//  Copyright (c) 2015年 Coder Shoryon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  图片加载来源
 */
typedef NS_ENUM(NSInteger, SXPictureCarouselRequestType){
    /**
     *  本地文件
     */
    SXPictureCarouselRequestTypeLocal = 0,
    /**
     *  网络URL
     */
    SXPictureCarouselRequestTypeUrl = 1,
    /**
     *  本地加密文件
     */
    SXPictureCarouselRequestTypeEncode = SXPictureCarouselRequestTypeLocal
};

@interface SXPictureCarousel : NSObject

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, assign) SXPictureCarouselRequestType requestType;

- (instancetype)initWithImageName:(NSString *)imageName;
+ (instancetype)initWithImageName:(NSString *)imageName;
- (instancetype)initWithRequestUrl:(NSString *)requestUrl;
+ (instancetype)initWithRequestUrl:(NSString *)requestUrl;
- (instancetype)initWithTitleName:(NSString *)titleName imageName:(NSString *)imageName;
+ (instancetype)initWithTitleName:(NSString *)titleName imageName:(NSString *)imageName;
- (instancetype)initWithTitleName:(NSString *)titleName requestUrl:(NSString *)requestUrl;
+ (instancetype)initWithTitleName:(NSString *)titleName requestUrl:(NSString *)requestUrl;

@end
