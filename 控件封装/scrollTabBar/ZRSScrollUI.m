//
//  ZRSScrollUI.m
//  控件封装
//
//  Created by 赵瑞生 on 16/9/7.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "ZRSScrollUI.h"
#import "UIview+Frame.h"

#define  ScreenW [UIScreen mainScreen].bounds.size.width
#define  ScreenH [UIScreen mainScreen].bounds.size.height
#define  Font(size) [UIFont systemFontOfSize:size]

static NSString *const ID = @"cell";
static NSString *const CollectionID = @"COLLECTION";

typedef NS_ENUM(NSInteger, ViewContentStyle) {
    ViewContentStyleNavigation,
    ViewContentStyleSearchView,
};



@interface ZRSScrollUI ()<UICollectionViewDelegate, UICollectionViewDataSource>
/**
 *  标题视图
 */
@property (nonatomic, weak) UIScrollView *topTitleView;
/**
 *  标题按钮
 */
@property (nonatomic, weak) UIButton *titleButton;
/**
 *  内容
 */
@property (nonatomic, weak) UICollectionView *collection;
/**
 *  按钮宽度
 */
@property (nonatomic, assign) CGFloat BTwidth;
/**
 *  标题下标
 */
@property (nonatomic, strong) UIView *underLine;
/**
 *  保存按钮的数组
 */
@property (nonatomic, strong) NSMutableArray *buttons;
/**
 *  字体大小
 */
@property (nonatomic, assign) CGFloat fontSize;
/**
 *  下标高度
 */
@property (nonatomic, assign) CGFloat underLineH;
/**
 *  判断有没有搜索View
 */
@property (nonatomic, assign) BOOL isSearchView;

@end

@implementation ZRSScrollUI


- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (UIView *)underLine
{
    if (_underLine == nil) {
        _underLine = [[UIView alloc] init];
        _underLine.backgroundColor = [UIColor redColor];
        [self.topTitleView addSubview:_underLine];
    }
    return _underLine;
}
- (void)onceParameterConfig:(void (^)(CGFloat, CGFloat, CGFloat, BOOL))textAttriabdUnderSize setupAllController:(void (^)())setupAllChildController
{
    CGFloat fontSize = 15;
    CGFloat underLineHeight = 1;
    CGFloat number = 5;
    BOOL isSearchView;
    
    if (textAttriabdUnderSize) {
        textAttriabdUnderSize(fontSize, underLineHeight, number,isSearchView);
        if (fontSize) {
            _fontSize = fontSize;
        }
        
        if (underLineHeight) {
            _underLineH = underLineHeight;
        }
        
        if (number) {
            _BTwidth = (ScreenW / number);
        }
        if (isSearchView) {
            _isSearchView = isSearchView;
        }
    } else {
        self.BTwidth = ScreenW / number;
    }
    if (setupAllChildController) {
        [self setupAllChildController:setupAllChildController];
    }
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self setupScrollViewWhitTiteleView];

    
    //默认值设置
    [self setupAllTitleButton:15 underLineHeight:2 normalColor:[UIColor blackColor] selectedColor:[UIColor redColor]];
    
    [self setupCollectionView];
}

- (void)setupAllTitleButton:(CGFloat)fontSize underLineHeight:(CGFloat)underLineHeight normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor
{
    CGFloat btnX = 0.0;
    CGFloat btnY = 0.0;
    CGFloat btnW = _BTwidth;
    CGFloat btnH = _topTitleView.height;
    //遍历标题
    for (int i = 0; i < self.childViewControllers.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btnX = btnW * i;
        btn.frame = CGRectMake(btnW * i, _topTitleView.bounds.origin.y, btnW, btnH);
//        btn.titleLabel.font = self.fontSize == 0 ? Font(fontSize) : Font(_fontSize);
        btn.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        btn.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(didClickControllerTransition:) forControlEvents:UIControlEventTouchUpInside];

        [self.topTitleView addSubview:btn];
        [self.buttons addObject:btn];
        
        if (i == 0) {
            [btn.titleLabel sizeToFit];
            [self didClickControllerTransition:btn];
            //下标的粗度
            CGFloat h = self.underLineH == 0 ? underLineHeight : self.underLineH;
            self.underLine.height = h;
            self.underLine.y = _topTitleView.height - h;
            self.underLine.width = btn.titleLabel.width;
            self.underLine.centerX = btn.centerX;
        }
        
    }
    
}

//切换控制器
- (void)didClickControllerTransition:(UIButton *)button
{
    _titleButton.selected = NO;
    button.selected = YES;
    _titleButton = button;
    
    _collection.contentOffset = CGPointMake(button.tag * ScreenW, 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.underLine.width = button.titleLabel.width;
        self.underLine.centerX = button.centerX;
    }];
    [self scrollViewOfSet:button];
    
}

- (void)scrollViewOfSet:(UIButton *)button
{
    CGFloat offsetX = button.center.x - ScreenW * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    //计算最大的标题试图滚动区域
    CGFloat maxOffsetX = self.topTitleView.contentSize.width - ScreenW;
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    //滚动区域
    [self.topTitleView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / ScreenW;
    UIButton *button = self.buttons[index];
    [self didClickControllerTransition:button];
}




- (void)setupAllChildController:(void(^)())setupAllChildController
{
    setupAllChildController();
}



- (void)setupScrollViewWhitTiteleView
{
    UIScrollView *topTitleView = [[UIScrollView alloc] init];
    CGFloat y = 0;
    topTitleView.frame = CGRectMake(0, 64, ScreenW, 44);
    topTitleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    topTitleView.contentSize = CGSizeMake(self.childViewControllers.count * _BTwidth, topTitleView.height);
    topTitleView.pagingEnabled = YES;
    topTitleView.showsHorizontalScrollIndicator = NO;
    topTitleView.backgroundColor = [UIColor blueColor];
    _topTitleView = topTitleView;
    [self.view addSubview:_topTitleView];
}


- (void)setupCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(ScreenW, ScreenH - 60 - 64);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,  64 + 60, ScreenW, self.view.height - 64 - 60) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.bounces = NO;
    _collection = collectionView;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionID];
    [self.view addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionID forIndexPath:indexPath];
    
    //移除之前的view
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *child = self.childViewControllers[indexPath.row];
    if ([child isKindOfClass:[UITableViewController class]]) {
        UITableViewController *vc = (UITableViewController *)child;
        vc.view.frame = cell.bounds;
        vc.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(_topTitleView.frame), 0, 0, 0);
    } else if ([child isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)child;
        vc.view.frame = cell.bounds;
    } else {
        child.view.frame = CGRectMake(0, CGRectGetMidY(_topTitleView.frame), ScreenW, ScreenH - child.view.y);
    }
    [cell.contentView addSubview:child.view];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
