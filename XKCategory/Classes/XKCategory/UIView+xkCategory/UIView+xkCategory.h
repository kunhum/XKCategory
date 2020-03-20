//
//  UIView+XKCategory.h
//  FateTeacher-IOS
//
//  Created by Nicholas on 2017/11/15.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (xkCategory)

///从nib获取view
+ (instancetype _Nullable )xk_viewFromNib;

///将alpha改为1.0
- (void)xk_showWithAlphaAnimation;

///添加点击事件
- (void)xk_addTarget:(id _Nonnull )target action:(SEL _Nonnull )action;

/// 设置背景颜色自动和系统暗黑模式对应
- (void)xk_setBackgroundColorToSystemColor;

/// 在对应深浅色模式下执行的任务
/// @param lightStyle 浅色模式
/// @param darkStyle 深色模式
- (void)xk_excuteTaskInLightStyle:(nullable void(^)(void))lightStyle darkStyle:(nullable void(^)(void))darkStyle;

/// 根据深浅模式设置颜色
/// @param lightColor 浅色
/// @param darkColor 深色
- (UIColor *_Nonnull)xk_colorInStyleLight:(NSString *_Nonnull)lightColor dark:(NSString *_Nonnull)darkColor;

/// 切圆角
/// @param rect frame
/// @param corners 圆角
/// @param radii radii
/// @param layerHandler layerHandler
- (void)xk_setCornerRadiusWithRect:(CGRect)rect corners:(UIRectCorner)corners radii:(CGSize)radii layerHandler:(CAShapeLayer *_Nonnull(^_Nonnull)(CAShapeLayer * _Nonnull shareLayer, UIBezierPath * _Nonnull maskPath))layerHandler;

@end
