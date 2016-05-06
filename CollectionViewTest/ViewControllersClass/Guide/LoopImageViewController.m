//
//  LoopImageViewController.m
//  CollectionViewTest
//
//  Created by 小四 on 16/4/1.
//  Copyright © 2016年 Riluee. All rights reserved.
//

#import "LoopImageViewController.h"
#import "LoopImageView.h"
@interface LoopImageViewController ()

@end

@implementation LoopImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    LoopImageView *view =[[LoopImageView alloc]
                          initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)
                          images:@[@"0",@"1",@"2",@"3"]];
    [view startTimer];
    [self.view addSubview:view];
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

@end
