//
//  ViewController.m
//  SXPictureCarousel
//
//  Created by 沧海小鱼 on 15/7/7.
//  Copyright (c) 2015年 Coder Shoryon. All rights reserved.
//

#import "ViewController.h"
#import "SXPictureCarouselView.h"

@interface ViewController () <SXPictureCarouselViewDelegate>

@property (weak, nonatomic) IBOutlet SXPictureCarouselView *pictureCarouselView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //使用storyboard中用约束布局时，加导航控制器需要配置top的高度
    self.pictureCarouselView.imageEdgeInsets = UIEdgeInsetsMake(-64.0f, 0, 0, 0);
    self.pictureCarouselView.scrollTimeInterval = 2.0f;
    self.pictureCarouselView.delegate = self;
    self.pictureCarouselView.photos = @[[SXPictureCarousel initWithTitleName:@"我的彩票"
                                                                  requestUrl:@"http://www.lottery.gov.cn/topic/daletou_kxq/images/m10.jpg"],
                                        [SXPictureCarousel initWithTitleName:@"我的彩票"
                                                                  requestUrl:@"http://www.lottery.gov.cn/topic/daletou_kxq/images/m9.jpg"],
                                        [SXPictureCarousel initWithTitleName:@"我的彩票"
                                                                  requestUrl:@"http://www.lottery.gov.cn/topic/daletou_kxq/images/m7a.jpg"],
                                        [SXPictureCarousel initWithTitleName:@"我的彩票"
                                                                  requestUrl:@"http://www.lottery.gov.cn/topic/daletou_kxq/images/m4a.jpg"],
                                        [SXPictureCarousel initWithTitleName:@"我的彩票"
                                                                  requestUrl:@"http://www.lottery.gov.cn/topic/daletou_kxq/images/m3a.jpg"],
                                        [SXPictureCarousel initWithTitleName:@"我的彩票"
                                                                  requestUrl:@"http://www.lottery.gov.cn/topic/daletou_kxq/images/m1a.jpg"]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.pictureCarouselView.scrollTimeInterval = 1.0f;
    self.pictureCarouselView.photos = @[[SXPictureCarousel initWithTitleName:@"a"
                                                                  requestUrl:@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=2210a00a09b30f2435cfbf43aea8e571/bd315c6034a85edfd428f5484f540923dd547530.jpg"],
                                        [SXPictureCarousel initWithTitleName:@"b"
                                                                  requestUrl:@"https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=1f8c1f4493cad1c8d0eeaf671903533b/a044ad345982b2b7ff6036af37adcbef77099bd9.jpg"],
                                        [SXPictureCarousel initWithTitleName:@"c"
                                                                  requestUrl:@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=2210a00a09b30f2435cfbf43aea8e571/bd315c6034a85edfd428f5484f540923dd547530.jpg"],
                                        [SXPictureCarousel initWithTitleName:@"d"
                                                                  requestUrl:@"https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=1f8c1f4493cad1c8d0eeaf671903533b/a044ad345982b2b7ff6036af37adcbef77099bd9.jpg"]];
}

#pragma mark - picture carousel view delegate

- (void)pictureCarouselView:(SXPictureCarouselView *)pictureCarouselView didClickedItem:(SXPictureCarousel *)item {
    
    NSLog(@"did clicked item is %@", item);
}

@end
