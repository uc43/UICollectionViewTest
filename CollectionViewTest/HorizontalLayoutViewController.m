//
//  HorizontalLayoutViewController.m
//  CollectionViewTest
//
//  Created by 小四 on 16/4/11.
//  Copyright © 2016年 Riluee. All rights reserved.
//

#import "HorizontalLayoutViewController.h"
#import "XSCreateLayout.h"
#import "CollectionViewCell.h"
@interface HorizontalLayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) XSCreateLayout *layout;

@end
static NSString * const identifier =@"item007";

@implementation HorizontalLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    

    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil];

    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, 250.0, 35.0);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引

    
    [segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView =segmentedControl;
    
    
    _layout =[[XSCreateLayout alloc]initWithAnimation:XSLayoutAnimation1];
    _layout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    _layout.itemSize =CGSizeMake(250, 250);
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:_layout];
    self.collectionView.showsVerticalScrollIndicator =NO;
    self.collectionView.showsHorizontalScrollIndicator =NO;
    self.collectionView.delegate =self;
    self.collectionView.dataSource =self;
    self.collectionView.backgroundColor =self.view.backgroundColor;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld", indexPath.row);
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //    item.backgroundColor =[UIColor redColor];
    item.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"00%ld", indexPath.row % 4]];
    return item;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)segmentedControlAction:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            _layout.animation =XSLayoutAnimation2;
            break;
        case 1:
            _layout.animation =XSLayoutAnimation3;
            break;
        case 2:
            _layout.animation =XSLayoutAnimation4;
            break;
        case 3:
            _layout.animation =XSLayoutAnimation5;
            break;
            
        default:
            break;
    }
    
    [_collectionView reloadData];
}
@end
