//
//  UIView+XKCategory.m
//  FateTeacher-IOS
//
//  Created by Nicholas on 2017/11/15.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import "UIView+xkCategory.h"
#import "UIColor+ZXLazy.h"

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

- (void)xk_setBackgroundColorToSystemColor {
    
    if (@available(iOS 13.0, *)) {
        
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.backgroundColor = UIColor.systemBackgroundColor;
        }
        
    } else {
        // Fallback on earlier versions
    }
    
    
}

- (void)xk_excuteTaskInLightStyle:(nullable void (^)(void))lightStyle darkStyle:(nullable void (^)(void))darkStyle {
    
    if (@available(iOS 13.0, *)) {
        
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            
            !darkStyle ?: darkStyle();
        }
        else {
            
            !lightStyle ?: lightStyle();
        }
        
    } else {
        // Fallback on earlier versions
    }
}

- (UIColor *)xk_colorInStyleLight:(NSString *)lightColor dark:(NSString *)darkColor {
    
    if (@available(iOS 13.0, *)) {
        
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            
            return [UIColor colorWithHexString:darkColor];
        }
        else {
            
            return [UIColor colorWithHexString:lightColor];
        }
        
    } else {
        // Fallback on earlier versions
        
        return [UIColor colorWithHexString:lightColor];
    }
}

- (void)xk_setCornerRadiusWithRect:(CGRect)rect corners:(UIRectCorner)corners radii:(CGSize)radii layerHandler:(CAShapeLayer *(^)(CAShapeLayer *, UIBezierPath *))layerHandler {
    
    CAShapeLayer *shareLayer = [CAShapeLayer new];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    shareLayer.frame = rect;
    
    shareLayer.path = maskPath.CGPath;
    
    if (layerHandler) {
        shareLayer = layerHandler(shareLayer, maskPath);
    }
    
    self.layer.mask = shareLayer;
}

@end
