//
//  ViewController.m
//  控件封装
//
//  Created by 赵瑞生 on 16/9/7.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "ViewController.h"
#import "ScrollTestViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"进入" forState:0];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)click
{
    ScrollTestViewController *controller = [[ScrollTestViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
