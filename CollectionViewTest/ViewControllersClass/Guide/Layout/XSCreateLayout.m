//
//  XSCreateLayout.m
//  CollectionViewTest
/**
 
   有3个方法是必定会被依次调用：
 
  1.prepareLayout: 准备所有view的layoutAttribute信息
 
  2.collectionViewContentSize: 计算contentsize，显然这一步得在prepare之后进行
 
  3.layoutAttributesForElementsInRect: 返回在可见区域的view的layoutAttribute信息
 
 */
//  Created by 小四 on 16/4/8.
//  Copyright © 2016年 Riluee. All rights reserved.
//

#import "XSCreateLayout.h"
static CGFloat const INTERSPACEPARAM =0.65;
@interface XSCreateLayout ()

@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) CGFloat itemHeight;

@end

@implementation XSCreateLayout


- (instancetype)initWithAnimation:(XSLayoutAnimation)animation {
    
    if (self =[super init]) {
        
        self.animation =animation;
    }
    return self;
}

#pragma mark --实现该方法后应该调用［super prepareLayout］保证初始化正确。该方法用来准备一些布局所需要的信息。该方法和init方法相似，但该方法可能会被调用多次，所以一些不固定的计算（比如该计算和collectionView的尺寸相关），最好放在这里，以保证collectionView发生变化时，自定义CollectionView能做出正确的反应。
- (void)prepareLayout {
    
    /**
     *  最好把对于layout的frame的定义写到这里
     */
    [super prepareLayout];
    
    if (self.visibleCount < 1) {
        self.visibleCount = 5;
    }
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        _viewHeight = CGRectGetHeight(self.collectionView.frame);
        _itemHeight = self.itemSize.height;
        //居中
        self.collectionView.contentInset = UIEdgeInsetsMake((_viewHeight - _itemHeight) / 2, 0, (_viewHeight - _itemHeight) / 2, 0);
    } else {
        _viewHeight = CGRectGetWidth(self.collectionView.frame);
        _itemHeight = self.itemSize.width;
        self.collectionView.contentInset = UIEdgeInsetsMake(0, (_viewHeight - _itemHeight) / 2, 0, (_viewHeight - _itemHeight) / 2);
    }
}

#pragma mark --用来刷新layout的，当我们返回yes的时候。如果我们的需求不需要实时的刷新layout，那么最好判断newBounds 和 我们的collectionView的bounds是否相同，不同时返回yes
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    /**
     *   只要UICollectionView的边界发生了改变就会调用这个方法，内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性，所有是重新定义layout必须实现的方法
     */
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

- (CGSize)collectionViewContentSize {
   
    /**
     *  返回可偏移的size
     */
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        return CGSizeMake(CGRectGetWidth(self.collectionView.frame), cellCount * _itemHeight);
    }
    return CGSizeMake(cellCount * _itemHeight, CGRectGetHeight(self.collectionView.frame));

}
#pragma mark --该方法不是必须实现的，即便你实现了，我们对collectionView的任何操作，也不会导致系统主动调用该方法。该方法通常用来定制某个IndexPath的item的属性。当然我们也可以重写这个方法，将布局时相关的属性设置放在这里
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    /**
     *  返回path这个位置Item的布局属性
     */
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.size = self.itemSize;
    
    CGFloat cY = (self.scrollDirection == UICollectionViewScrollDirectionVertical ? self.collectionView.contentOffset.y : self.collectionView.contentOffset.x) + _viewHeight / 2;
    CGFloat attributesY = _itemHeight * path.row + _itemHeight / 2;
    attributes.zIndex = -ABS(attributesY - cY);
    
    CGFloat delta = cY - attributesY;
    CGFloat ratio =  - delta / (_itemHeight * 2);
    CGFloat scale = 1 - ABS(delta) / (_itemHeight * 6.0) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat centerY = attributesY;
    switch (self.animation) {
        case XSLayoutAnimation2:
            attributes.transform = CGAffineTransformRotate(attributes.transform, - ratio * M_PI_4);
            centerY += sin(ratio * M_PI_2) * _itemHeight / 2;
            break;
        case XSLayoutAnimation3:
            centerY = cY + sin(ratio * M_PI_2) * _itemHeight * INTERSPACEPARAM;
            break;
        case XSLayoutAnimation4:
            centerY = cY + sin(ratio * M_PI_2) * _itemHeight * INTERSPACEPARAM;
            if (delta > 0 && delta <= _itemHeight / 2) {
                attributes.transform = CGAffineTransformIdentity;
                CGRect rect = attributes.frame;
                if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
                    rect.origin.x = CGRectGetWidth(self.collectionView.frame) / 2 - _itemSize.width * scale / 2;
                    rect.origin.y = centerY - _itemHeight * scale / 2;
                    rect.size.width = _itemSize.width * scale;
                    CGFloat param = delta / (_itemHeight / 2);
                    rect.size.height = _itemHeight * scale * (1 - param) + sin(0.25 * M_PI_2) * _itemHeight * INTERSPACEPARAM * 2 * param;
                } else {
                    rect.origin.x = centerY - _itemHeight * scale / 2;
                    rect.origin.y = CGRectGetHeight(self.collectionView.frame) / 2 - _itemSize.height * scale / 2;
                    rect.size.height = _itemSize.height * scale;
                    CGFloat param = delta / (_itemHeight / 2);
                    rect.size.width = _itemHeight * scale * (1 - param) + sin(0.25 * M_PI_2) * _itemHeight * INTERSPACEPARAM * 2 * param;
                }
                attributes.frame = rect;
                return attributes;
            }
            break;
        case XSLayoutAnimation5: {
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -1.0/400.0f;
            transform = CATransform3DRotate(transform, ratio * M_PI_4, 1, 0, 0);
            attributes.transform3D = transform;
        }
            break;
        default:
            break;
    }
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        attributes.center = CGPointMake(CGRectGetWidth(self.collectionView.frame) / 2, centerY);
    } else {
        attributes.center = CGPointMake(centerY, CGRectGetHeight(self.collectionView.frame) / 2);
    }
    
    return attributes;

}

#pragma mark --该方法用来返回rect范围内的 cell supplementary 以及 decoration的布局属性layoutAttributes（这里保存着她们的尺寸，位置，indexPath等等），如果你的布局都在一个屏幕内 活着 没有复杂的计算，我觉得这里可以返回全部的属性数组，如果涉及到复杂计算，应该进行判断，返回区域内的属性数组，有时候为了方便直接返回了全部的属性数组，不影响布局但可能会影响性能（如果你的item一屏幕显示不完，那么这个方法会调用多次，当所有的item都加载完毕后，在滑动collectionView时不会调用该方法的）
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    /**
     *  返回rect范围内的布局属性
     */
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat centerY = (self.scrollDirection == UICollectionViewScrollDirectionVertical ? self.collectionView.contentOffset.y : self.collectionView.contentOffset.x) + _viewHeight / 2;
    NSInteger index = centerY / _itemHeight;
    NSInteger count = (self.visibleCount - 1) / 2;
    //展示的起始点
    NSInteger minIndex = MAX(0, (index - count));
    //展示的终点
    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        //将所展示的item属性添加到数组中
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    return array;

}



#pragma mark --插入操作
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
//    attributes.center = CGPointMake(_center.x, _center.y);
    return attributes;
}
#pragma mark --删除操作
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
//    attributes.center = CGPointMake(_center.x, _center.y);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
}

#pragma mark --分页效果

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat index = roundf(((self.scrollDirection == UICollectionViewScrollDirectionVertical ? proposedContentOffset.y : proposedContentOffset.x) + _viewHeight / 2 - _itemHeight / 2) / _itemHeight);
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        proposedContentOffset.y = _itemHeight * index + _itemHeight / 2 - _viewHeight / 2;
    } else {
        proposedContentOffset.x = _itemHeight * index + _itemHeight / 2 - _viewHeight / 2;
    }
    return proposedContentOffset;
}
@end
