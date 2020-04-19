//
//  XKBaseControllerConfig.h
//  XKBaseController_Example
//
//  Created by Nicholas on 2018/12/10.
//  Copyright © 2018 kunhum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XKBaseControllerConfig : NSObject

+ (instancetype)shareConfig;

#pragma mark - tabbar
/**
 设置tabbar背景图

 @param backgroundImage 背景图
 */
+ (void)xk_setTabbarBackgroundImage:(UIImage *)backgroundImage;

/**
 设置tabbar bar tint color

 @param barTintColor 颜色
 */
+ (void)xk_setTabbarBarTintColor:(UIColor *)barTintColor;

/**
 设置tabbar tint color

 @param tintColor 颜色
 */
+ (void)xk_setTabbarTintColor:(UIColor *)tintColor;

/**
 设置tabbar 角标颜色, ios 10之后起作用

 @param badgeColor 颜色
 */
+ (void)xk_setTabbarItemBadgeColor:(UIColor *)badgeColor;

///tabbar背景图
@property (nonatomic, strong) UIImage *tabbarBackgroundImage;
///tabbar bar tint color
@property (nonatomic, strong) UIColor *tabbarBarTintColor;
///tabbar tint color
@property (nonatomic, strong) UIColor *tabbarTintColor;
///tabbar 角标颜色 badge color
@property (nonatomic, strong) UIColor *tabbarBadgeColor;

#pragma mark - navigation controller

/**
 设置导航栏返回按钮图片

 @param backButtonImage 图片
 */
+ (void)xk_setNavigationBarBackButtonImage:(UIImage *)backButtonImage;

/**
 设置返回手势要忽略的类

 @param ignoredClass 类集合
 */
+ (void)xk_setNavigationBarBackGestureIgnoredClass:(NSArray <Class>*)ignoredClass;

///导航栏返回按钮图片
@property (nonatomic, strong) UIImage *navigationBarBackButtonImage;

///返回手势要忽略的类
@property (nonatomic, strong) NSArray <Class >*navigationBarBackGestureIgnoredClass;

@end

NS_ASSUME_NONNULL_END
