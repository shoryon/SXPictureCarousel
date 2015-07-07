//
//  PictureCarouselView.m
//  PictureCarousel
//
//  Created by 沧海小鱼 on 15/4/17.
//  Copyright (c) 2015年 Coder Shoryon. All rights reserved.
//

#import "SXPictureCarouselView.h"
#import "SXPictureCarouselViewCell.h"

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kPictureCarouselViewTimeInterval 3
#define kPictureCarouselViewSections 10
#define kPictureCarouselViewCurrentPageIndicatorTintColor RGBColor(213, 39, 64)
#define kPictureCarouselViewPageIndicatorTintColor RGBColor(245, 245, 245)
#define kPictureCarouselViewCellW self.frame.size.width
#define kPictureCarouselViewCellH self.frame.size.height
#define kPictureCarouselViewBorderTop 0
#define kPictureCarouselViewBorderLeft 0
#define kPictureCarouselViewBorderRight 0
#define kPictureCarouselViewBorderBottom 0

@interface SXPictureCarouselView () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation SXPictureCarouselView

static NSString *identifier = @"SXPictureCarouselCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupPictureCarouselView];
        [self setupPageControl];
        [self startTimer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupPictureCarouselView];
        [self setupPageControl];
        [self startTimer];
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos {
    
    _photos = photos;
    
    if (_photos) {
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = self.photos.count;
        [self.collectionView reloadData];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    
    CGFloat centerX = self.frame.size.width * 0.5;
    CGFloat centerY = self.frame.size.height - 10;
    self.pageControl.center = CGPointMake(centerX, centerY);
}

/**
 *  添加PictureCarouselView
 */
- (void)setupPictureCarouselView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    [collectionView setBounces:NO];
    [collectionView setPagingEnabled:YES];
    [collectionView setShowsHorizontalScrollIndicator:NO];
    [collectionView setShowsVerticalScrollIndicator:NO];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerNib:[UINib nibWithNibName:@"SXPictureCarouselViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    [self addSubview:collectionView];
    
    self.collectionView = collectionView;
}

/**
 *  添加PageControl
 */
- (void)setupPageControl {
    
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    
    [self addSubview:pageControl];
    
    self.pageControl = pageControl;
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = kPictureCarouselViewCurrentPageIndicatorTintColor;
    pageControl.pageIndicatorTintColor = kPictureCarouselViewPageIndicatorTintColor;
}

#pragma mark 设置图片定时滚动

/**
 *  启动图片定时器
 */
- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kPictureCarouselViewTimeInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

/**
 *  关闭图片定时器
 */
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *  获取重置后的位置
 */
- (NSIndexPath *)resetIndexPath {
    
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:kPictureCarouselViewSections * 0.5];
    
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    return currentIndexPathReset;
}

/**
 *  设置每次滚动的范围
 */
- (void)autoScroll {
    
    // 有图片才进行滚动
    if (self.photos.count > 0) {
        
        // 1.马上显示回最中间那组的数据
        NSIndexPath *currentIndexPathReset = [self resetIndexPath];
        
        // 2.计算出下一个需要展示的位置
        NSInteger nextItem = currentIndexPathReset.item + 1;
        NSInteger nextSection = currentIndexPathReset.section;
        if (nextItem == self.photos.count) {
            nextItem = 0;
            nextSection++;
        }
        
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
        
        // 3.通过动画滚动到下一个位置
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

#pragma mark scroll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self startTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}

#pragma mark collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.photos.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return kPictureCarouselViewSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SXPictureCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.pictureCarousel = self.photos[indexPath.item];
    
    return cell;
}

#pragma mark collection view delegate flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kPictureCarouselViewCellW, kPictureCarouselViewCellH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(kPictureCarouselViewBorderTop, kPictureCarouselViewBorderLeft, kPictureCarouselViewBorderBottom, kPictureCarouselViewBorderRight);
}

#pragma mark collection view delegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    self.pageControl.currentPage = indexPath.item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(pictureCarouselView:didClickedItem:)]) {
        [self.delegate pictureCarouselView:self didClickedItem:self.photos[indexPath.row]];
    }
}

@end
