//
//  UITableView+xkCategory.m
//  benGangTai
//
//  Created by Nicholas on 2017/12/28.
//  Copyright © 2017年 xiaopao. All rights reserved.
//

#import "UITableView+xkCategory.h"
#import "UIScrollView+xkCategory.h"

@implementation UITableView (xkCategory)

#pragma mark 刷新数据
- (void)xk_reloadData {
    UITableView *tableView = (UITableView *)self;
    if (self.page == 1 || self.page == 0) [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    else [tableView reloadData];
}

#pragma mark 刷新分区
- (void)xk_reloadSection:(NSInteger)section animation:(UITableViewRowAnimation)animation {
    [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:animation];
}
- (void)xk_reloadSection:(NSInteger)section {
    [self xk_reloadSection:section animation:UITableViewRowAnimationAutomatic];
}

@end
