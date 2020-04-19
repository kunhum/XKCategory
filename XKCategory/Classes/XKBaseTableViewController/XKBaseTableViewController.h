//
//  XKBaseTableViewController.h
//  MBB
//
//  Created by Nicholas on 2018/12/20.
//  Copyright © 2018 Nicholas. All rights reserved.
//

#import "XKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *baseCellIdentifier = @"baseCellIdentifier";

@interface XKBaseTableViewController : XKBaseViewController <UITableViewDataSource, UITableViewDelegate>

///设置基础配置
- (void)xk_setBaseConfiguration;
///默认为plain,会重新设置tableView，如果在此方法前复制的属性将作废
- (void)xk_setTableViewStyle:(UITableViewStyle)style;

/**
 创建headerView

 @param height 高度
 @param color 背景颜色
 @return 视图
 */
- (UIView *)xk_headerViewWithHeight:(CGFloat)height color:(UIColor *)color;

@property (nonatomic, strong) UITableView *tableView;



@end

NS_ASSUME_NONNULL_END
