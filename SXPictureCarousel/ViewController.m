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
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation ViewController

- (NSMutableArray *)photos {
    if (!_photos) {
        _photos = [NSMutableArray array];
        [_photos addObject:[[SXPictureCarousel alloc] initWithRequestUrl:@"https://avatars0.githubusercontent.com/u/13197827?v=3&s=460"]];
        [_photos addObject:[[SXPictureCarousel alloc] initWithRequestUrl:@"https://avatars0.githubusercontent.com/u/13197827?v=3&s=460"]];
        [_photos addObject:[[SXPictureCarousel alloc] initWithRequestUrl:@"https://avatars0.githubusercontent.com/u/13197827?v=3&s=460"]];
        [_photos addObject:[[SXPictureCarousel alloc] initWithRequestUrl:@"https://avatars0.githubusercontent.com/u/13197827?v=3&s=460"]];
        [_photos addObject:[[SXPictureCarousel alloc] initWithRequestUrl:@"https://avatars0.githubusercontent.com/u/13197827?v=3&s=460"]];
        [_photos addObject:[[SXPictureCarousel alloc] initWithRequestUrl:@"https://avatars0.githubusercontent.com/u/13197827?v=3&s=460"]];
    }
    return _photos;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pictureCarouselView.delegate = self;
    self.pictureCarouselView.photos = self.photos;
}

#pragma mark - picture carousel view delegate

- (void)pictureCarouselView:(SXPictureCarouselView *)pictureCarouselView didClickedItem:(SXPictureCarousel *)item {
    
    NSLog(@"did clicked item is %@", item);
}

@end
