//
//  LoopImageView.m
//  CollectionViewTest
//
//  Created by 小四 on 16/4/1.
//  Copyright © 2016年 Riluee. All rights reserved.
//

#import "LoopImageView.h"
@interface LoopImageView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)   UICollectionView *collectionView;
@property (nonatomic, strong)   NSTimer *timer;
@property (nonatomic, strong)   UIPageControl *pageCtrl;
@end

static NSString * const itemID = @"LoopImageView";

@implementation LoopImageView



- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    
    if (self) {
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize =frame.size;
        layout.minimumLineSpacing =0;
        layout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        
        
        self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        self.collectionView.pagingEnabled =YES;
        self.collectionView.showsVerticalScrollIndicator =NO;
        self.collectionView.showsHorizontalScrollIndicator =NO;
        self.collectionView.delegate =self;
        self.collectionView.dataSource =self;
        [self addSubview:self.collectionView];
        
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:itemID];
        
        
        _pageCtrl = [[UIPageControl alloc]init];
        
        //总页数
        _pageCtrl.numberOfPages = self.images.count;
        //控件尺寸
        CGSize size = [_pageCtrl sizeForNumberOfPages:self.images.count];
        
        _pageCtrl.frame = CGRectMake(self.collectionView.center.x-size.width/2, self.collectionView.center.y*1.7, size.width, size.height);

        
        //设置颜色
        _pageCtrl.pageIndicatorTintColor = [UIColor redColor];
        
        _pageCtrl.currentPageIndicatorTintColor = [UIColor blackColor];
        
        
        
        //添加监听方法
        [_pageCtrl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageCtrl];
        
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.bounces = NO;//去掉弹簧效果
    self.collectionView.showsHorizontalScrollIndicator = NO;//去掉水平显示的拖拽线
    self.collectionView.pagingEnabled = YES;//分页效果
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)image {
    
    self.images =image;
//    [self scrollViewDidScroll:self.collectionView];
    return [self initWithFrame:frame];
    
    
}


#pragma mark - NSTimUICollectionViewer

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *item =[collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:_images[indexPath.item]]];
    imageView.contentMode =UIViewContentModeScaleAspectFill;
    item.backgroundView =imageView;
    
    return item;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"%ld",indexPath.item);
}
#pragma mark - NSTimer

- (void)startTimer {
    
    self.timer =[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(loadTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)stopTimer {
    
    [self.timer invalidate];
    self.timer =nil;
}

- (void)loadTimer {
    
    NSUInteger count = self.images.count;
    if (count == 0) {
        NSLog(@"图片个数是0");
        return;
    }
   int page = (self.pageCtrl.currentPage+1) % (int)count;
    
    self.pageCtrl.currentPage = page;
    //调用监听方法。让滚动视图滚动
    [self pageChanged:self.pageCtrl];
    
}

#pragma mark - UIScrollView

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    

    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
  
    self.pageCtrl.currentPage = page;

    
}

- (void)pageChanged:(UIPageControl *)sender {
    
    [self stopTimer];
    //根据页数，调整滚动视图中得图片位置contentOffset
    CGFloat x = sender.currentPage * self.bounds.size.width;
    [self.collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
    
//    NSLog(@"%@",NSStringFromCGRect(sender.frame));
    
    [self startTimer];
    
}
@end
