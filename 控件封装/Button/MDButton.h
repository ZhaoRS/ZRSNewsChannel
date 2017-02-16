//
//  MDButton.h
//  控件封装
//
//  Created by 赵瑞生 on 16/9/7.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MDButtonType) {
    MDButtonTypeRaised,
    MDButtonTypeFlat,
    MDButtonTypeFloatingAction,
    MDButtonTypeFloatingActionRoation
};

@protocol MDButtonDelegate <NSObject>

@optional
- (void)rotationStarted:(id)sender;
- (void)rotationCompleted:(id)sender;

@end

@interface MDButton : UIButton


@property (nonatomic) UIColor *rippleColor;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic) UIImage *imageNormal;
@property (nonatomic) UIImage *imageRotated;

@property (nonatomic) MDButtonType mdButtonType;
@property (nonatomic, getter=isRotated) BOOL rotated;
@property (nonatomic, weak) id <MDButtonDelegate> mdButtonDelegate;

- (instancetype)initWithFrame:(CGRect)frame
                         type:(MDButtonType)buttonType
                  rippleColor:(UIColor *)rippleColor;



@end
