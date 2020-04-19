//
//  UIViewController+xkCategory.m
//  BlindDate
//
//  Created by Nicholas on 2017/12/4.
//  Copyright © 2017年 Skingen. All rights reserved.
//

#import "UIViewController+xkCategory.h"
#import <UIColor+ZXLazy.h>
#import <UIImage+xkCategory.h>
#import "XKCategoryDefines.h"

@implementation UIViewController (xkCategory)

+ (UIViewController *)xk_currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

+ (UIViewController *)findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

#pragma mark 从sb获取controler
+ (id)xk_initFromStoryBoard:(NSString *)sbName {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}
+ (id)xk_initFromXib {
    return [[self alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
}

- (void)xk_setClearBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage xk_imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0] frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, XK_STATUS_BAR_AND_NAVIGATION_BAR_HEIGHT)] forBarMetrics:UIBarMetricsDefault];
    [self xk_hideNavigationBarBlackLine];
}

#pragma mark 重置导航栏
- (void)xk_resetNavigationBar {
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self xk_showNavigationBarBlackLine];
    
}
#pragma mark 设置导航栏左按钮
- (void)xk_setLeftNavigationBarItemWithImage:(UIImage *)image action:(SEL _Nullable)action {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[image xk_OriginalRenderingImage] style:UIBarButtonItemStylePlain target:self action:action];
    
}
- (void)xk_setLeftNavigationBarItemWithButtonTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
#pragma mark 设置导航栏右按钮
- (void)xk_setRightNavigationBarItemWithImage:(UIImage *)image action:(_Nullable SEL)action {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[image xk_OriginalRenderingImage] style:UIBarButtonItemStylePlain target:self action:action];
}
- (void)xk_setRightNavigationBarItemWithButtonTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark 返回上一页
- (void)xk_popOrDismiss {
    
    self.presentingViewController ? [self dismissViewControllerAnimated:YES completion:nil] : [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 自定义导航栏标题
- (void)xk_setNavigationItemTitle:(NSString *)title color:(UIColor *)color {
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    titleLabel.textColor = color;
    titleLabel.text = title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - 公共方法
#pragma mark 显示导航栏黑线
- (void)xk_showNavigationBarBlackLine {
    UIImageView* blackLineImageView = [self getBarBlackLine];
    blackLineImageView.hidden = NO;
}
#pragma mark 隐藏导航栏黑线
- (void)xk_hideNavigationBarBlackLine {
    UIImageView* blackLineImageView = [self getBarBlackLine];
    blackLineImageView.hidden = YES;
}

#pragma mark - 私有方法
#pragma mark 找出导航栏黑线
- (UIImageView *)getBarBlackLine {
    return [self findHairlineImageViewUnder:self.navigationController.navigationBar];
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
        return (UIImageView *)view;
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) return imageView;
    }
    return nil;
}

//#pragma mark 设置屏幕旋转方向
//- (void)xk_changeDeviceToOrintation:(UIDeviceOrientation)orientation shouldAutorotate:(BOOL)shouldAutorotate {
//
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.shouldRotatingScreen = shouldAutorotate;
//    [UIDevice currentDevice].xkOrintation = orientation;
//}

@end
