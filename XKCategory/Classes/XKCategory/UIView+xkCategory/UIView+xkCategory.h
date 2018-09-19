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
+ (instancetype)xk_viewFromNib;

///将alpha改为1.0
- (void)xk_showWithAlphaAnimation;

///添加点击事件
- (void)xk_addTarget:(id)target action:(SEL)action;

@end
