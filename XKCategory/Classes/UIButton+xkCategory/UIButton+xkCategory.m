//
//  UIButton+xkCategory.m
//  PinShangHome
//
//  Created by Nicholas on 2018/8/6.
//  Copyright © 2018年 com.xiaopao. All rights reserved.
//

#import "UIButton+xkCategory.h"
#import <objc/runtime.h>

#define XK_RATIO (XK_SCREEN_WIDTH/375.0)
#define XK_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define XK_SMALL_SCREEN (XK_SCREEN_WIDTH < 375.0)

@implementation UIButton (xkCategory)

+ (void)load {
    [super load];
    
    Method codeInitMethod   = class_getInstanceMethod(self, @selector(initWithCoder:));
    Method xkCodeInitMethod = class_getInstanceMethod(self, @selector(xk_initWithCoder:));
    if (XK_SMALL_SCREEN) {
        method_exchangeImplementations(codeInitMethod, xkCodeInitMethod);
    }
}

- (instancetype)xk_initWithCoder:(NSCoder *)aDecoder {
    
    [self xk_initWithCoder:aDecoder];
    
    if (self) {
        
        [self xk_adjustFont];
    }
    
    return self;
}

#pragma mark 适配文字
- (void)xk_adjustFont {
    
    CGFloat fontSize = self.titleLabel.font.pointSize;
    UIFont *xkFont   = [UIFont fontWithName:self.titleLabel.font.familyName size:fontSize*XK_RATIO];
    self.titleLabel.font = xkFont;
}

- (void)setDoNotAdjustFont:(BOOL)doNotAdjustFont {
    objc_setAssociatedObject(self, @"doNotAdjustFont", @(doNotAdjustFont), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)doNotAdjustFont {
    NSNumber *number = objc_getAssociatedObject(self, @"doNotAdjustFont");
    return number.boolValue;
}

@end
