//
//  GuideCollectionViewController.m
//  CollectionViewTest
//
//  Created by 小四 on 16/3/31.
//  Copyright © 2016年 Riluee. All rights reserved.
//

//动态获取设备高度
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
//动态获取设备宽度
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width

#import "GuideCollectionViewController.h"
#import "GuideCollectionViewCell.h"
@interface GuideCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSArray *guideImages;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl *pageCtrl;
@end

@implementation GuideCollectionViewController

static NSString * const reuseIdentifier = @"GuideItem";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
  
    self.guideImages = @[@"引导页01",@"引导页02",@"引导页03",@"引导页04"];
    
    
    /**
     
     视图页
     
     */
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.pagingEnabled =YES;
    self.collectionView.showsVerticalScrollIndicator =NO;
    self.collectionView.showsHorizontalScrollIndicator =NO;
    self.collectionView.delegate =self;
    self.collectionView.dataSource =self;
    [self.view addSubview:self.collectionView];

    [self.collectionView registerNib:[UINib nibWithNibName:@"GuideCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    /**
     分页标识
     */
    
    self.pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(IPHONE_WIDTH/2-50, IPHONE_HEIGHT-50, 100, 20)];
    self.pageCtrl.numberOfPages = self.guideImages.count;
    self.pageCtrl.currentPage = 0;
    [self.view addSubview:self.pageCtrl];
    
    // Do any additional setup after loading the view.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = (scrollView.contentOffset.x + IPHONE_WIDTH * 0.5)/ IPHONE_WIDTH;
    self.pageCtrl.currentPage = index;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.guideImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GuideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.GuideImage =[UIImage imageNamed:self.guideImages[indexPath.item]];
    if (indexPath.item ==self.guideImages.count-1) {
        cell.hiden =YES;
    }else{
        cell.hiden =NO;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
