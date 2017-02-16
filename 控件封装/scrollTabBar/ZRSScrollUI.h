//
//  ZRSScrollUI.h
//  控件封装
//
//  Created by 赵瑞生 on 16/9/7.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRSScrollUI : UIViewController

@property (nonatomic, strong) UISearchBar *searchBar;

- (void)onceParameterConfig:(void(^)(CGFloat fontSize, CGFloat underLineHeight, CGFloat number, BOOL isSearchView)) textAttriabdUnderSize setupAllController:(void(^)())setupAllChildController;

@end
