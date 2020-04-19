//
//  UINavigationController+xkCategory.h
//  FateTeacher-IOS
//
//  Created by Nicholas on 2017/12/18.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (xkCategory)

///移除子控制器
- (void)xk_removeViewController:(UIViewController *)viewController;
///移除子控制器
- (void)xk_removeViewControllerFromIndex:(NSUInteger)index;
///移除子控制器
- (void)xk_removeViewControllerWithRange:(NSRange)range;
///移除子控制器
- (void)xk_removeViewControllers:(NSArray *)vcs;
///插入控制器
- (void)xk_insertViewController:(UIViewController *)vc atIndex:(NSInteger)index;

@end
