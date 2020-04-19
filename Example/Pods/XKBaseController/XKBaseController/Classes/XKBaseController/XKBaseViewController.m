//
//  BaseViewController.m
//  Minshuku
//
//  Created by Nicholas on 16/4/13.
//  Copyright © 2016年 Nicholas. All rights reserved.
//

#import "XKBaseViewController.h"

@interface XKBaseViewController ()

@end

@implementation XKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    
    if (self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem.image = [self.navigationItem.rightBarButtonItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

#pragma mark - 公共方法
#pragma mark 显示导航栏黑线
- (void)xk_showNavigationBarBlackLine {
    UIImageView* blackLineImageView = [self getBarBlackLine];
    //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
    blackLineImageView.hidden = NO;
}
#pragma mark 隐藏导航栏黑线
- (void)xk_hideNavigationBarBlackLine {
    UIImageView* blackLineImageView = [self getBarBlackLine];
    //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
    blackLineImageView.hidden = YES;
}
#pragma mark - 从故事板获取控制器
+ (id)xk_initControllerFromStoryBoard:(NSString *)sbName {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
