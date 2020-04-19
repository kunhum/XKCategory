//
//  UIScrollView+xkCategory.m
//  PinShangHome
//
//  Created by Nicholas on 2017/9/22.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import "UIScrollView+xkCategory.h"
#import "MJRefresh.h"
#import <objc/runtime.h>

@implementation UIScrollView (xkCategory)

//#pragma mark - 设置刷新头
//- (void)xk_setGifHeaderWithRefreshingBlock:(void (^)())refreshingBlock {
//    
//    XKRefreshGifHeader *header = [XKRefreshGifHeader headerWithRefreshingBlock:^{
//        if (refreshingBlock) refreshingBlock();
//    }];
//    [header xk_setOnlyGifWithImages:[BBGTool xk_getRefreshHeaderAnimationImages] duration:1.5];
//    self.mj_header = header;
//}

//#pragma mark - 一次性设置头与脚
//- (void)xk_setGifHeaderWithRefreshingBlock:(XKRefreshingBlock)headerRefreshingBlock backStateFooterWithRefreshingBlock:(XKRefreshingBlock)footerRefreshingBlock {
//    
//    //头
//    if (headerRefreshingBlock) {
//        XKRefreshGifHeader *header = [XKRefreshGifHeader headerWithRefreshingBlock:^{
//            if (headerRefreshingBlock) headerRefreshingBlock();
//        }];
//        [header xk_setOnlyGifWithImages:[BBGTool xk_getRefreshHeaderAnimationImages] duration:1.5];
//        self.mj_header = header;
//    }
//    
//    //脚
//    if (footerRefreshingBlock) {
//        self.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
//            if (footerRefreshingBlock) footerRefreshingBlock();
//        }];
//    }
//}

#pragma mark ----- 普通刷新
#pragma mark 普通刷新头
- (void)xk_setNormalHeaderWithRefreshingBlock:(XKRefreshingBlock)refreshingBlock {
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        if (weakSelf.mj_footer) [weakSelf.mj_footer resetNoMoreData];
        if (refreshingBlock) refreshingBlock(weakSelf);
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}

#pragma mark 设置刷新脚
- (void)xk_setBackStateFooterWithRefreshingBlock:(XKRefreshingBlock)refreshingBlock {
    __weak typeof(self) weakSelf = self;
    
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        if (refreshingBlock) refreshingBlock(weakSelf);
    }];
    self.mj_footer = footer;
    [footer setTitle:@"加载更多..." forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多..." forState:MJRefreshStatePulling];
    [footer setTitle:@"加载更多..." forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    
}

#pragma mark auto footer
- (void)xk_setAutoFooterWithRefreshingBlock:(XKRefreshingBlock)refreshingBlock {
    
    __weak typeof(self) weakSelf = self;
    
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        if (refreshingBlock) refreshingBlock(weakSelf);
    }];
    self.mj_footer = footer;
    [footer setTitle:@"加载更多..." forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多..." forState:MJRefreshStatePulling];
    [footer setTitle:@"加载更多..." forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
}

#pragma mark 一次性设置普通刷新头与脚
- (void)xk_setNormalHeaderWithRefreshingBlock:(XKRefreshingBlock)headerRefreshingBlock backStateFooterWithRefreshingBlock:(XKRefreshingBlock)footerRefreshingBlock {
    self.page = 1;
    if (headerRefreshingBlock) [self xk_setNormalHeaderWithRefreshingBlock:headerRefreshingBlock];
    if (footerRefreshingBlock) [self xk_setBackStateFooterWithRefreshingBlock:footerRefreshingBlock];
}

#pragma mark 设置普通刷新头和Auto Footer
- (void)xk_setNormalHeaderWithRefreshingBlock:(XKRefreshingBlock)headerRefreshingBlock autoStateFooterWithRefreshingBlock:(XKRefreshingBlock)footerRefreshingBlock {
    
    self.page = 1;
    if (headerRefreshingBlock) [self xk_setNormalHeaderWithRefreshingBlock:headerRefreshingBlock];
    if (footerRefreshingBlock) [self xk_setAutoFooterWithRefreshingBlock:footerRefreshingBlock];
}

#pragma mark - 结束刷新
- (void)xk_endRefreshing {
    
    if (self.mj_header.isRefreshing) [self.mj_header endRefreshing];
    if (self.mj_footer.isRefreshing) [self.mj_footer endRefreshing];
}

- (void)setPage:(NSInteger)page {
    objc_setAssociatedObject(self, @"page", @(page), OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)page {
    NSNumber *number = objc_getAssociatedObject(self, @"page");
    return number.integerValue;
}

#pragma mark 设置contentInsetAdjustmentBehavior
- (void)xk_configContentInsetAdjustmentNever {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        
    }
}

@end
