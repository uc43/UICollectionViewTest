//
//  GuideCollectionViewCell.m
//  CollectionViewTest
//
//  Created by 小四 on 16/3/31.
//  Copyright © 2016年 Riluee. All rights reserved.
//

#import "GuideCollectionViewCell.h"

@implementation GuideCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (void)setGuideImage:(UIImage *)GuideImage {
    
    self.GuideImageView.image =GuideImage;
    
}
- (void)setHiden:(BOOL)hiden {
    
    self.GuideBtn.hidden =!hiden;
}
@end
