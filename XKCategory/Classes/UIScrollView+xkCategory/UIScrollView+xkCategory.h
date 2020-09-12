//
//  UIScrollView+xkCategory.h
//  PinShangHome
//
//  Created by Nicholas on 2017/9/22.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XKRefreshingBlock)(UIScrollView *currentScrollView);

@interface UIScrollView (xkCategory)

///网络请求下标
@property (nonatomic, assign) int page;

///设置初始的请求下标，默认为1，在下拉刷新时将page重置为该值
+ (void)xk_setScrollViewOriginalPage:(int)originalPage;

///设置刷新脚
- (void)xk_setBackStateFooterWithRefreshingBlock:(XKRefreshingBlock)refreshingBlock;

///设置普通刷新头
- (void)xk_setNormalHeaderWithRefreshingBlock:(XKRefreshingBlock)refreshingBlock;

///设置自动刷新脚
- (void)xk_setAutoFooterWithRefreshingBlock:(XKRefreshingBlock)refreshingBlock;

///设置普通刷新头和脚
- (void)xk_setNormalHeaderWithRefreshingBlock:(XKRefreshingBlock)headerRefreshingBlock backStateFooterWithRefreshingBlock:(XKRefreshingBlock)footerRefreshingBlock;

///设置普通刷新头和Auto Footer
- (void)xk_setNormalHeaderWithRefreshingBlock:(XKRefreshingBlock)headerRefreshingBlock autoStateFooterWithRefreshingBlock:(XKRefreshingBlock)footerRefreshingBlock;

///结束刷新
- (void)xk_endRefreshing;

///设置contentInsetAdjustmentBehavior
- (void)xk_configContentInsetAdjustmentNever;


@end
