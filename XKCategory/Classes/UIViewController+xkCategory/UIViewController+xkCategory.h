//
//  UIViewController+xkCategory.h
//  BlindDate
//
//  Created by Nicholas on 2017/12/4.
//  Copyright © 2017年 Skingen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (xkCategory)

///获取当前控制器
+ (UIViewController *)xk_currentViewController;

///从sb获取controler
+ (id)xk_initFromStoryBoard:(NSString *)sbName;
///从xib获取
+ (id)xk_initFromXib;

///导航栏透明
- (void)xk_setClearBar;

///重置导航栏
- (void)xk_resetNavigationBar;

///设置导航栏左按钮
- (void)xk_setLeftNavigationBarItemWithImage:(UIImage *)image action:(_Nullable SEL)action;
///设置导航栏右按钮
- (void)xk_setRightNavigationBarItemWithImage:(UIImage *)image action:(_Nullable SEL)action;

///设置导航栏左按钮
- (void)xk_setLeftNavigationBarItemWithButtonTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font action:(_Nullable SEL)action;
///设置导航栏右按钮
- (void)xk_setRightNavigationBarItemWithButtonTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font action:(_Nullable SEL)action;

///返回上一页
- (void)xk_popOrDismiss;
///自定义导航栏标题
- (void)xk_setNavigationItemTitle:(NSString *)title color:(UIColor *)color;

///显示导航栏下方黑线
- (void)xk_showNavigationBarBlackLine;
///隐藏导航栏下方黑线
- (void)xk_hideNavigationBarBlackLine;


/**
 修改屏幕旋转
 
 @param orientation 方向
 @param shouldAutorotate 是否可以自动旋转
 */
//- (void)xk_changeDeviceToOrintation:(UIDeviceOrientation)orientation shouldAutorotate:(BOOL)shouldAutorotate;


@end
