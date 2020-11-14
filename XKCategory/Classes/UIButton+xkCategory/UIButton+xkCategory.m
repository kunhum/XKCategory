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
    
//    Method codeInitMethod   = class_getInstanceMethod(self, @selector(initWithCoder:));
//    Method xkCodeInitMethod = class_getInstanceMethod(self, @selector(xk_initWithCoder:));
//    if (XK_SMALL_SCREEN) {
//        method_exchangeImplementations(codeInitMethod, xkCodeInitMethod);
//    }
}

//- (instancetype)xk_initWithCoder:(NSCoder *)aDecoder {
//
//    [self xk_initWithCoder:aDecoder];
//
//    if (self) {
//
//        [self xk_adjustFont];
//    }
//
//    return self;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self xk_adjustFont];
}

#pragma mark 适配文字
- (void)xk_adjustFont {
    
    CGFloat fontSize   = self.titleLabel.font.pointSize;
    NSString *fontName = self.titleLabel.font.fontName;
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
