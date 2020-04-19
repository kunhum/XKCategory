//
//  UILabel+xkCategory.m
//  FateTeacher-IOS
//
//  Created by Nicholas on 2017/12/26.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import "UILabel+xkCategory.h"
#import <objc/runtime.h>

#define XK_RATIO (XK_SCREEN_WIDTH/375.0)
#define XK_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation UILabel (xkCategory)

+ (void)load {
    [super load];
    
    //交换是为了字体自适应
    Method fontMethod   = class_getInstanceMethod(self, @selector(setFont:));
    Method xkFontMethod = class_getInstanceMethod(self, @selector(xk_setFont:))
    ;
    method_exchangeImplementations(fontMethod, xkFontMethod);
    
    Method codeInitMethod   = class_getInstanceMethod(self, @selector(initWithCoder:));
    Method xkCodeInitMethod = class_getInstanceMethod(self, @selector(xk_initWithCoder:));
    method_exchangeImplementations(codeInitMethod, xkCodeInitMethod);
    
}

- (instancetype)xk_initWithCoder:(NSCoder *)aDecoder {
    
    [self xk_initWithCoder:aDecoder];
    
    if (self) {
        self.font = [UIFont fontWithName:self.font.fontName size:self.font.pointSize];
    }
    
    return self;
}

- (void)xk_setFont:(UIFont *)font {
    
    if (self.doNotAdjustFont || [NSStringFromClass(self.class) isEqualToString:@"UILabel"] == NO || [NSStringFromClass(self.superview.class) isEqualToString:@"UINavigationItemView"]) {
        [self xk_setFont:font];
        return;
    }
    CGFloat fontSize = font.pointSize;
    UIFont *xkFont = [UIFont fontWithName:font.fontName size:fontSize*XK_RATIO];
    
    [self xk_setFont:xkFont];
}

- (void)setDoNotAdjustFont:(BOOL)doNotAdjustFont {
    objc_setAssociatedObject(self, @"doNotAdjustFont", @(doNotAdjustFont), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)doNotAdjustFont {
    NSNumber *number = objc_getAssociatedObject(self, @"doNotAdjustFont");
    return number.boolValue;
}

@end
