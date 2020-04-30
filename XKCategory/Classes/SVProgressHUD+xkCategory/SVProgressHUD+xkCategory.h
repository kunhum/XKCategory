//
//  SVProgressHUD+xkCategory.h
//  BlindDate
//
//  Created by Nicholas on 2017/12/1.
//  Copyright © 2017年 Skingen. All rights reserved.
//

#import "SVProgressHUD.h"

#define kAnimationDuration (1.5)

@interface SVProgressHUD (xkCategory)

///show loading 无遮罩
+ (void)xk_show;
///show loading 有透明遮罩，视图不再交互
+ (void)xk_showWithClearMask;
+ (void)xk_showMessage:(NSString *)message completed:(void (^)(void))completed;
+ (void)xk_showWithStatus:(NSString *)message completed:(void(^)(void))completed;
///有透明遮罩
+ (void)xk_showClearMaskStatus:(NSString *)message;

/// 只显示文字
/// @param maskType 遮罩类型
/// @param message 文本
/// @param completed 回调
+ (void)xk_showMessage:(NSString *)message maskType:(SVProgressHUDMaskType)maskType completed:(void(^)(void))completed;

+ (void)xk_showLoadingWithStatus:(NSString *)message;
+ (void)xk_showErrorWithStatus:(NSString *)message completed:(void(^)(void))completed;
+ (void)xk_showInfoWithStatus:(NSString *)message completed:(void(^)(void))completed;
+ (void)xk_showSuccessWithStatus:(NSString *)message completed:(void(^)(void))completed;

@end
