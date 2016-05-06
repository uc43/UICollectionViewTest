//
//  XSCreateLayout.h
//  CollectionViewTest
//
//  Created by 小四 on 16/4/8.
//  Copyright © 2016年 Riluee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XSLayoutAnimation) {
    XSLayoutAnimation1, //Defaults --> UICollectionViewScrollDirectionVertical
    XSLayoutAnimation2,
    XSLayoutAnimation3,
    XSLayoutAnimation4,
    XSLayoutAnimation5,
    
};

@interface XSCreateLayout : UICollectionViewLayout

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) NSInteger visibleCount;
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;//Defaults --> UICollectionViewScrollDirectionVertical
@property (nonatomic, assign) XSLayoutAnimation animation;

- (instancetype)initWithAnimation:(XSLayoutAnimation)animation;



@end
