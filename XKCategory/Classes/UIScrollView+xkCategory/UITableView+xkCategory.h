//
//  UITableView+xkCategory.h
//  benGangTai
//
//  Created by Nicholas on 2017/12/28.
//  Copyright © 2017年 xiaopao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (xkCategory)

///刷新数据
- (void)xk_reloadData;

///刷新分区
- (void)xk_reloadSection:(NSInteger)section animation:(UITableViewRowAnimation)animation;

///刷新分区，默认动画为UITableViewRowAnimationAutomatic
- (void)xk_reloadSection:(NSInteger)section;

@end
