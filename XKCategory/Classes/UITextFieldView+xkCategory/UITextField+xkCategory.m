//
//  UITextField+xkCategory.m
//  PinShangHome
//
//  Created by Nicholas on 2017/11/24.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import "UITextField+xkCategory.h"
#import <objc/runtime.h>
#import "XKInsertLimiter.h"

#define XK_RATIO (XK_SCREEN_WIDTH/375.0)
#define XK_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation UITextField (xkCategory)

+ (void)load {
    [super load];
    
    //交换是为了字体自适应
    Method fontMethod   = class_getInstanceMethod(self, @selector(setFont:));
    Method xkFontMethod = class_getInstanceMethod(self, @selector(xk_setFont:))
    ;
    method_exchangeImplementations(fontMethod, xkFontMethod);
    
    Method frameMethod   = class_getInstanceMethod(self, @selector(initWithFrame:));
    Method xkFrmaeMethod = class_getInstanceMethod(self, @selector(xk_initWithFrame:));
    Method coderMethod   = class_getInstanceMethod(self, @selector(initWithCoder:));
    Method xkCoderMethod = class_getInstanceMethod(self, @selector(xk_initWithCoder:));
    
    method_exchangeImplementations(frameMethod, xkFrmaeMethod);
    method_exchangeImplementations(coderMethod, xkCoderMethod);
    
    //明暗文切换
    Method secureMethod   = class_getInstanceMethod(self, @selector(setSecureTextEntry:));
    Method xkSecureMethod = class_getInstanceMethod(self, @selector(xk_setSecureTextEntry:));
    method_exchangeImplementations(secureMethod, xkSecureMethod);
    
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
- (void)xk_setSecureTextEntry:(BOOL)secureTextEntry {
    
    [self xk_setSecureTextEntry:secureTextEntry];
    
    NSString *text = self.text;
    self.text = @" ";
    self.text = text;
    if (secureTextEntry) {
        [self insertText:self.text];
    }
}

#pragma mark 初始化时执行
- (void)initAction {
    self.insertLimit = [XKInsertLimiter new];
    self.insertLimit.maxLength   = 0;
    self.insertLimit.filterEmoji = YES;
    [self.insertLimit xk_starLimitingTextField:self];
    
    self.font = [UIFont fontWithName:self.font.fontName size:self.font.pointSize];
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


#pragma mark 限制输入数字和最多两位小数
- (BOOL)xk_justCanInsertNumberAndDecimalPointInChangeDelegateWithChangeString:(NSString *)string range:(NSRange)range {
    
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入两位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
    BOOL hasDian = NO;
    // 判断是否有小数点
    if ([self.text containsString:@"."]) {
        hasDian = YES;
    }else{
        hasDian = NO;
    }
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.')) return NO;
        
        // 只能有一个小数点
        if (hasDian && single == '.') return NO;
        
        // 如果第一位是.则前面加上0.
        if ((self.text.length == 0) && (single == '.')) self.text = @"0";
        
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([self.text hasPrefix:@"0"]) {
            if (self.text.length > 1) {
                NSString *secondStr = [self.text substringWithRange:NSMakeRange(1, 1)];
                //第二个字符需要是小数点
                if (![secondStr isEqualToString:@"."]) return NO;
            }else{
                //第二个字符需要是小数点
                if (![string isEqualToString:@"."]) return NO;
            }
        }
        
        // 小数点后最多能输入两位
        if (hasDian) {
            NSRange ran = [self.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                //小数点后最多有两位小数
                if ([self.text pathExtension].length > 1) return NO;
            }
        }
        
    }
    return YES;
    
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self.insertLimit xk_stopLimiting];
    self.insertLimit = nil;
}

@end
