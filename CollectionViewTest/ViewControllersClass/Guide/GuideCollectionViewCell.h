//
//  GuideCollectionViewCell.h
//  CollectionViewTest
//
//  Created by 小四 on 16/3/31.
//  Copyright © 2016年 Riluee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideCollectionViewCell : UICollectionViewCell
@property (assign ,nonatomic) BOOL hiden;
@property (strong ,nonatomic) UIImage *GuideImage;
@property (weak, nonatomic) IBOutlet UIImageView *GuideImageView;
@property (weak, nonatomic) IBOutlet UIButton *GuideBtn;

@end
