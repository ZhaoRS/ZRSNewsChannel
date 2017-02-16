//
//  ScrollTestViewController.m
//  控件封装
//
//  Created by 赵瑞生 on 16/9/8.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "ScrollTestViewController.h"
#import "TestViewController.h"

@interface ScrollTestViewController ()

@end

@implementation ScrollTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self onceParameterConfig:^(CGFloat fontSize, CGFloat underLineHeight, CGFloat number, BOOL isSearchView) {
       //修改标题导航栏字体大小， 默认为15
        fontSize = 30;
        //修改下标高度 默认为2
        underLineHeight = 2;
        //修改窗口中显示多少个标题
        number = 5;
        //是否有搜索栏
        isSearchView = NO;
    } setupAllController:^{
        [self setupAllChildController];
    }];
}

- (void)setupAllChildController
{
    TestViewController *controller1 = [[TestViewController alloc] init];
    controller1.title = @"全部";
    controller1.view.backgroundColor = [UIColor blackColor];
    [self addChildViewController:controller1];
    TestViewController *controller2 = [[TestViewController alloc] init];
    controller2.title = @"全部";
    controller2.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:controller2];
    TestViewController *controller3 = [[TestViewController alloc] init];
    controller3.title = @"全部";
    [self addChildViewController:controller3];
    TestViewController *controller4 = [[TestViewController alloc] init];
    controller4.title = @"全部";
    [self addChildViewController:controller4];
    TestViewController *controller5 = [[TestViewController alloc] init];
    controller5.title = @"全部";
    [self addChildViewController:controller5];
    
    TestViewController *controller6 = [[TestViewController alloc] init];
    controller6.title = @"4444";
    [self addChildViewController:controller6];
    
    TestViewController *controller7 = [[TestViewController alloc] init];
    controller7.title = @"aaaa";
    [self addChildViewController:controller7];
    
    TestViewController *controller8 = [[TestViewController alloc] init];
    controller8.title = @"cccc";
    [self addChildViewController:controller8];
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
