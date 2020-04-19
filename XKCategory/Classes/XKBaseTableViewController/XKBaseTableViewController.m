//
//  XKBaseTableViewController.m
//  MBB
//
//  Created by Nicholas on 2018/12/20.
//  Copyright © 2018 Nicholas. All rights reserved.
//

#import "XKBaseTableViewController.h"
#import "UIColor+ZXLazy.h"
#import "Masonry.h"
#import "XKCategoryDefines.h"
#import "UIView+xkFrameCategory.h"

@interface XKBaseTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *cellHeightCache;

@end

@implementation XKBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.cellHeightCache = [NSMutableDictionary dictionary];
    
    [self xk_setBaseConfiguration];
    
}

#pragma mark 设置基础配置
- (void)xk_setBaseConfiguration {
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:baseCellIdentifier];
    self.view.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
}
#pragma mark 重置tableView
- (void)xk_setTableViewStyle:(UITableViewStyle)style {
    
    [self.tableView removeFromSuperview];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    self.tableView.dataSource      = self;
    self.tableView.delegate        = self;
    self.tableView.tableFooterView = [UIView new];
    
//    if ([UIDevice currentDevice].systemVersion.floatValue < 11.0) {
//        self.tableView.estimatedRowHeight = 10.0;
//    }
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(XK_STATUS_BAR_AND_NAVIGATION_BAR_HEIGHT);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-XK_IPHONEX_SAFE_BOTTOM_MARGIN);
    }];
    
    if (style == UITableViewStyleGrouped) {
        self.tableView.backgroundView = [UIView new];
    }
}
#pragma mark 头视图
- (UIView *)xk_headerViewWithHeight:(CGFloat)height color:(UIColor *)color {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XK_SCREEN_WIDTH, height)];
    headerView.backgroundColor = color;
    return headerView;
}

#pragma mark table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UITableViewCell new];
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.cellHeightCache setObject:@(cell.xk_height) forKey:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = [self.cellHeightCache objectForKey:indexPath];
    return height ? height.floatValue : 100;
}

#pragma mark 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.tableFooterView = [UIView new];
        
//        if ([UIDevice currentDevice].systemVersion.floatValue < 11.0) {
//            _tableView.estimatedRowHeight = 10.0;
//        }
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(XK_STATUS_BAR_AND_NAVIGATION_BAR_HEIGHT);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-XK_IPHONEX_SAFE_BOTTOM_MARGIN);
        }];
        
    }
    return _tableView;
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
