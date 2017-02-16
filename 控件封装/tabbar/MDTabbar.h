//
//  MDTabbar.h
//  控件封装
//
//  Created by 赵瑞生 on 16/9/7.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMDTabBarHeight 48
#define kMDIndicatorHeight 2

@class MDTabbar;

@protocol MDTabbarDelegate <NSObject>

- (void)tabBar:(MDTabbar *)tabBar
didChangeSelectedIndex:(NSUInteger)selectedIndex;

@end

@interface MDTabbar : UIControl

@property (nonatomic) UIColor *textColor;
@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) UIColor *indicatorColor;
@property (nonatomic) UIColor *rippleColor;

@property (nonatomic) UIFont *textFont;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, weak) id <MDTabbarDelegate> delegate;
@property (nonatomic, readonly) NSInteger numberOfItems;

- (void)setItems:(NSArray *)items;
- (void)insertItem:(id)item atIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)replaceItem:(id)item adIndex:(NSUInteger)index;

- (NSArray *)tabs;

- (void)moveIndicatorToFrame:(CGRect)frame widthAnimated:(BOOL)animated;

@end
