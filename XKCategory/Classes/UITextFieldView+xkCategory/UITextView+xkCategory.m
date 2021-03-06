//
//  UITextView+xkCategory.m
//  PinShangHome
//
//  Created by Nicholas on 2018/1/25.
//  Copyright © 2018年 com.xiaopao. All rights reserved.
//

#import "UITextView+xkCategory.h"
#import <objc/runtime.h>
#import "XKInsertLimiter.h"

#define XK_RATIO (XK_SCREEN_WIDTH/375.0)
#define XK_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation UITextView (xkCategory)

+ (void)load {
    
    Method frameMethod   = class_getInstanceMethod(self, @selector(initWithFrame:));
    Method xkFrmaeMethod = class_getInstanceMethod(self, @selector(xk_initWithFrame:));
    Method coderMethod   = class_getInstanceMethod(self, @selector(initWithCoder:));
    Method xkCoderMethod = class_getInstanceMethod(self, @selector(xk_initWithCoder:));
    
    method_exchangeImplementations(frameMethod, xkFrmaeMethod);
    method_exchangeImplementations(coderMethod, xkCoderMethod);
    
    //交换是为了字体自适应
    Method fontMethod   = class_getInstanceMethod(self, @selector(setFont:));
    Method xkFontMethod = class_getInstanceMethod(self, @selector(xk_setFont:))
    ;
    method_exchangeImplementations(fontMethod, xkFontMethod);
    
}

#pragma mark - 私有方法
- (instancetype)xk_initWithFrame:(CGRect)frame {
    if ([self xk_initWithFrame:frame]) {
        [self initAction];
    }
    return self;
}
- (instancetype)xk_initWithCoder:(NSCoder *)aDecoder {
    if ([self xk_initWithCoder:aDecoder]) {
        [self initAction];
    }
    return self;
}
#pragma mark 初始化时执行
- (void)initAction {
    self.insertLimit = [XKInsertLimiter new];
    [self.insertLimit xk_starLimitingTextView:self];
    
    CGFloat fontSize   = self.font.pointSize;
    
    NSString *fontName = self.font.fontName;
    
    UIFont *xkFont     = nil;
    
    if ([fontName isEqualToString:@".SFUI-Regular"]) {
        xkFont = [UIFont systemFontOfSize:fontSize*XK_RATIO];
    }
    else if ([fontName isEqualToString:@".SFUI-Bold"]) {
        xkFont = [UIFont systemFontOfSize:fontSize*XK_RATIO weight:UIFontWeightBold];
    }
    else if ([fontName isEqualToString:@".SFUI-Medium"]) {
        xkFont = [UIFont systemFontOfSize:fontSize*XK_RATIO weight:UIFontWeightMedium];
    }
    else if ([fontName isEqualToString:@".SFUI-Semibold"]) {
        xkFont = [UIFont systemFontOfSize:fontSize*XK_RATIO weight:UIFontWeightSemibold];
    }
    else {
        xkFont = [UIFont fontWithName:fontName size:fontSize*XK_RATIO];
    }
    
    self.font = xkFont;
}

- (void)setInsertLimit:(XKInsertLimiter *)insertLimit {
    objc_setAssociatedObject(self, @"insertLimit", insertLimit, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (XKInsertLimiter *)insertLimit {
    return objc_getAssociatedObject(self, @"insertLimit");
}

- (void)xk_setFont:(UIFont *)font {
    
    if (self.doNotAdjustFont) {
        [self xk_setFont:font];
        return;
    }
    
    CGFloat fontSize   = font.pointSize;
    
    NSString *fontName = font.fontName;
    
    UIFont *xkFont     = nil;
    
    if ([fontName isEqualToString:@".SFUI-Regular"]) {
        xkFont = [UIFont systemFontOfSize:fontSize*XK_RATIO];
    }
    else if ([fontName isEqualToString:@".SFUI-Bold"]) {
        xkFont = [UIFont systemFontOfSize:fontSize*XK_RATIO weight:UIFontWeightBold];
    }
    else if ([fontName isEqualToString:@".SFUI-Medium"]) {
        xkFont = [UIFont systemFontOfSize:fontSize*XK_RATIO weight:UIFontWeightMedium];
    }
    else if ([fontName isEqualToString:@".SFUI-Semibold"]) {
        xkFont = [UIFont systemFontOfSize:fontSize*XK_RATIO weight:UIFontWeightSemibold];
    }
    else {
        xkFont = [UIFont fontWithName:fontName size:fontSize*XK_RATIO];
    }
    
    [self xk_setFont:xkFont];
}

- (void)setDoNotAdjustFont:(BOOL)doNotAdjustFont {
    objc_setAssociatedObject(self, @"doNotAdjustFont", @(doNotAdjustFont), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)doNotAdjustFont {
    NSNumber *number = objc_getAssociatedObject(self, @"doNotAdjustFont");
    return number.boolValue;
}

//- (void)removeFromSuperview {
//    [super removeFromSuperview];
//    [self.insertLimit xk_stopLimiting];
//}

@end
