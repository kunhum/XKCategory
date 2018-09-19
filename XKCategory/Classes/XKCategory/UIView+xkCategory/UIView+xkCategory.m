//
//  UIView+XKCategory.m
//  FateTeacher-IOS
//
//  Created by Nicholas on 2017/11/15.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import "UIView+xkCategory.h"

@implementation UIView (xkCategory)

#pragma mark 将alpha改为1.0
- (void)xk_showWithAlphaAnimation {
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1.0;
    }];
    
}

+ (instancetype)xk_viewFromNib {
    id view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    return view;
}

#pragma mark 添加点击事件
- (void)xk_addTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

@end
