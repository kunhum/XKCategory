//
//  XKBaseTabBarController.m
//  YTPedigree
//
//  Created by Nicholas on 2018/5/2.
//  Copyright © 2018年 Nicholas. All rights reserved.
//

#import "XKBaseTabBarController.h"
#import "XKBaseControllerConfig.h"

@interface XKBaseTabBarController ()

@end

@implementation XKBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.tabBar setBarTintColor:[UIColor orangeColor]];
    
    for (UITabBarItem *item in self.tabBar.items) {
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        if (@available(iOS 10.0, *)) {
            item.badgeColor = [XKBaseControllerConfig shareConfig].tabbarBadgeColor;
        } else {
            // Fallback on earlier versions
            
        }
    }
    
    if ([XKBaseControllerConfig shareConfig].tabbarBackgroundImage) {
        self.tabBar.backgroundImage = [XKBaseControllerConfig shareConfig].tabbarBackgroundImage;
    }
    
    if ([XKBaseControllerConfig shareConfig].tabbarBarTintColor) {
        self.tabBar.barTintColor = [XKBaseControllerConfig shareConfig].tabbarBarTintColor;
    }
    
    if ([XKBaseControllerConfig shareConfig].tabbarTintColor) {
        self.tabBar.tintColor = [XKBaseControllerConfig shareConfig].tabbarTintColor;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
