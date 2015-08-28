//
//  PictureCarouselView.m
//  PictureCarousel
//
//  Created by 沧海小鱼 on 15/4/17.
//  Copyright (c) 2015年 Coder Shoryon. All rights reserved.
//

#import "SXPictureCarouselView.h"
#import "SXPictureCarouselViewCell.h"

#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kPictureCarouselViewTimeInterval 3.0
#define kPictureCarouselViewSections 100
#define kPictureCarouselViewCurrentPageIndicatorTintColor RGBAColor(255, 255, 255, 1.0)
#define kPictureCarouselViewPageIndicatorTintColor RGBAColor(245, 245, 245, 0.8)
#define kPictureCarouselViewCellW self.frame.size.width
#define kPictureCarouselViewCellH self.frame.size.height

@interface SXPictureCarouselView () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger section;

@end

@implementation SXPictureCarouselView

static NSString *identifier = @"SXPictureCarouselCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupPictureCarouselView];
        [self setupPageControl];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupPictureCarouselView];
        [self setupPageControl];
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos {
    
    _photos = photos;
    
    if (_photos) {
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = self.photos.count;
        [self.collectionView reloadData]; //_photos被重新设置时,需要刷新数据
    }
    
    // 只有一张图片,则禁用图片滚动
    self.collectionView.scrollEnabled = _photos.count > 1;
    
    // 启动图片滚动定时器
    [self startTimer];
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
    
    // 1.添加分页控件
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
 *  启动图片滚动定时器
 */
- (void)startTimer {
    if (!self.scrollTimeInterval) { //设置默认滚动时间间隔
        self.scrollTimeInterval = kPictureCarouselViewTimeInterval;
    }
    if (self.timer) { //重复设置滚动时间间隔时，需要清除之前的定时器。
        [self stopTimer];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
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
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0];
    
    return currentIndexPathReset;
}

/**
 *  设置每次滚动的范围
 */
- (void)autoScroll {
    
    // 至少图片要多余1张才进行滚动
    if (self.photos.count > 1) {
        
        // 1.马上显示回最中间那组的数据
        NSIndexPath *currentIndexPathReset = [self resetIndexPath];
        
        [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset
                                    atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        
        // 2.计算出下一个需要展示的位置
        NSInteger nextItem = currentIndexPathReset.item + 1;
        NSInteger nextSection = currentIndexPathReset.section;
        if (nextItem == self.photos.count) {
            nextItem = 0;
            nextSection++;
        }
        
        // 3.通过动画滚动到下一个位置
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem
                                                                         inSection:nextSection]
                                    atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

#pragma mark scroll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self startTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.photos) {
        
        NSInteger pageIndex = (NSInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.photos.count;
        
        self.pageControl.currentPage = pageIndex;
    }
}

#pragma mark collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.photos.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return kPictureCarouselViewSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SXPictureCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                                forIndexPath:indexPath];
    cell.pictureCarousel = self.photos[indexPath.item];
    
    return cell;
}

#pragma mark collection view delegate flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kPictureCarouselViewCellW, kPictureCarouselViewCellH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (self.imageEdgeInsets.top &&
        self.imageEdgeInsets.left &&
        self.imageEdgeInsets.right &&
        self.imageEdgeInsets.bottom) {
        return UIEdgeInsetsZero;
    } else {
        return self.imageEdgeInsets;
    }
}

#pragma mark collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(pictureCarouselView:didClickedItem:)]) {
        [self.delegate pictureCarouselView:self didClickedItem:self.photos[indexPath.row]];
    }
}

@end
