//
//  XKBaseControllerConfig.m
//  XKBaseController_Example
//
//  Created by Nicholas on 2018/12/10.
//  Copyright © 2018 kunhum. All rights reserved.
//

#import "XKBaseControllerConfig.h"

@implementation XKBaseControllerConfig

+ (instancetype)shareConfig {
    
    static XKBaseControllerConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [XKBaseControllerConfig new];
    });
    return config;
}

#pragma mark - tabbar
#pragma mark 设置tabbar背景图
+ (void)xk_setTabbarBackgroundImage:(UIImage *)backgroundImage {
    
    [XKBaseControllerConfig shareConfig].tabbarBackgroundImage = backgroundImage;
}

#pragma mark 设置tabbar bar tint color
+ (void)xk_setTabbarBarTintColor:(UIColor *)barTintColor {
    [XKBaseControllerConfig shareConfig].tabbarBarTintColor = barTintColor;
}

#pragma mark 设置tabbar tint color
+ (void)xk_setTabbarTintColor:(UIColor *)tintColor {
    [XKBaseControllerConfig shareConfig].tabbarTintColor = tintColor;
}

#pragma mark 设置tabbar 角标颜色
+ (void)xk_setTabbarItemBadgeColor:(UIColor *)badgeColor {
    [XKBaseControllerConfig shareConfig].tabbarBadgeColor = badgeColor;
}

#pragma mark - navigation controller
#pragma mark 设置导航栏返回按钮图片
+ (void)xk_setNavigationBarBackButtonImage:(UIImage *)backButtonImage {
    [XKBaseControllerConfig shareConfig].navigationBarBackButtonImage = backButtonImage;
}

#pragma mark 设置返回手势要忽略的类
+ (void)xk_setNavigationBarBackGestureIgnoredClass:(NSArray <Class>*)ignoredClass {
    [XKBaseControllerConfig shareConfig].navigationBarBackGestureIgnoredClass = ignoredClass;
}

@end
