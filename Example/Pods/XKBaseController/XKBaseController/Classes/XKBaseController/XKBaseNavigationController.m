//
//  BaseNavigationController.m
//  Minshuku
//
//  Created by Nicholas on 16/4/24.
//  Copyright © 2016年 Nicholas. All rights reserved.
//

#import "XKBaseNavigationController.h"
#import "XKBaseControllerConfig.h"

@interface XKBaseNavigationController () <UIGestureRecognizerDelegate> {
    
    BOOL _shouldAutorotate;
}

@end

@implementation XKBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //重写代理方法，使自定义返回控件是返回手势有效
    self.interactivePopGestureRecognizer.delegate = self;
    
    //修改tab bar item的数据
    self.tabBarItem.selectedImage = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

#pragma mark- 重写系统方法，修改返回按键样式

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        if ([XKBaseControllerConfig shareConfig].navigationBarBackButtonImage) {
            
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[XKBaseControllerConfig shareConfig].navigationBarBackButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(handleBackButton)];
            
            viewController.navigationItem.leftBarButtonItem = leftItem;
            
        }
        
    }

    [super pushViewController:viewController animated:animated];
}
- (void)handleBackButton {
    
    [self popViewControllerAnimated:YES];
}

#pragma mark- UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([XKBaseControllerConfig shareConfig].navigationBarBackGestureIgnoredClass) {
        for (id class in [XKBaseControllerConfig shareConfig].navigationBarBackGestureIgnoredClass) {
            
            NSString *currentClass = NSStringFromClass(self.topViewController.class);
            NSString *comparedClass = NSStringFromClass(class);
            
            if ([currentClass isEqualToString:comparedClass]) {
                return NO;
            }
        }
    }
    
    return self.childViewControllers.count > 1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
