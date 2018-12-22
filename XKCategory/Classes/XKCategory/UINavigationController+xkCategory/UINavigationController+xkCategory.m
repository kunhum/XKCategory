//
//  UINavigationController+xkCategory.m
//  FateTeacher-IOS
//
//  Created by Nicholas on 2017/12/18.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import "UINavigationController+xkCategory.h"

@implementation UINavigationController (xkCategory)

#pragma mark 移除子控制器
- (void)xk_removeViewController:(UIViewController *)viewController {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewControllers removeObject:viewController];
    self.viewControllers = viewControllers;
}
- (void)xk_removeViewControllerFromIndex:(NSUInteger)index {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewControllers removeObjectAtIndex:index];
    self.viewControllers = viewControllers;
}
- (void)xk_removeViewControllerWithRange:(NSRange)range {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewControllers removeObjectsInRange:range];
    self.viewControllers = viewControllers;
}
- (void)xk_removeViewControllers:(NSArray *)vcs {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewControllers removeObjectsInArray:vcs];
    self.viewControllers = viewControllers;
}
- (void)xk_insertViewController:(UIViewController *)vc atIndex:(NSInteger)index {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    if (viewControllers.count < index) {
        return;
    }
    [viewControllers insertObject:vc atIndex:index];
    self.viewControllers = viewControllers;
}

@end
