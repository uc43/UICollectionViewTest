//
//  LoopImageView.h
//  CollectionViewTest
//
//  Created by 小四 on 16/4/1.
//  Copyright © 2016年 Riluee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopImageView : UIView

@property (nonatomic, strong) NSArray *images;

- (instancetype) initWithFrame:(CGRect)frame images:(NSArray *)image;

- (void) startTimer;
- (void) stopTimer;

@end
