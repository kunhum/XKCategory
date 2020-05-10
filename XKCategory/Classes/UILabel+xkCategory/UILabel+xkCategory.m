//
//  UILabel+xkCategory.m
//  FateTeacher-IOS
//
//  Created by Nicholas on 2017/12/26.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import "UILabel+xkCategory.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

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
    
    return self;
}

- (void)xk_setFont:(UIFont *)font {
    
    if (self.doNotAdjustFont || [NSStringFromClass(self.class) isEqualToString:@"UILabel"] == NO || [NSStringFromClass(self.superview.class) isEqualToString:@"UINavigationItemView"]) {
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

- (void)xk_setLineBreakByTruncatingLastLineWithWidth:(CGFloat)width suffixText:(NSString *)suffixText suffixTextColor:(UIColor *)suffixTextColor lineSpacing:(CGFloat)lineSpacing {
    
    if ( self.numberOfLines <= 0 ) {
        return;
    }
    NSArray *separatedLines = [self getSeparatedLinesArray:width];
    
    NSMutableString *limitedText = [NSMutableString string];
    
    NSString *omitText = @"...";
    
    if (separatedLines.count > self.numberOfLines) {
        
        for (int i = 0 ; i < self.numberOfLines; i++) {
            
            //最后一行，到达限制的一行
            if ( i == self.numberOfLines - 1) {
                
                NSArray *subSeparatedLines  = separatedLines;
                NSString *lastLineText      = subSeparatedLines[i];
                NSInteger lastLineTextCount = lastLineText.length;
                
                if ([[lastLineText substringFromIndex:(lastLineTextCount - 1)] isEqualToString:@"\n"]) {
                    lastLineText = [lastLineText substringToIndex:(lastLineText.length - 1)];
                    lastLineTextCount = lastLineTextCount - 1;
                }
                
                NSInteger length = suffixText.length + 1;
                [limitedText appendString:[lastLineText substringToIndex:lastLineText.length - length]];
            }
            //未到达限制
            else {
                [limitedText appendString:separatedLines[i]];
            }
        }
        
    }
    else {
        [limitedText appendString:self.text];
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString: (( separatedLines.count > self.numberOfLines ) ? [limitedText stringByAppendingString:[NSString stringWithFormat:@"%@%@", omitText, suffixText]] : limitedText) attributes:@{ NSForegroundColorAttributeName : self.textColor, NSFontAttributeName : self.font, NSParagraphStyleAttributeName : style }];
    if ( separatedLines.count > self.numberOfLines ) {
        [attText addAttributes:@{
                                NSFontAttributeName : [UIFont systemFontOfSize:15*XK_RATIO],
                                NSForegroundColorAttributeName : suffixTextColor
                                } range:NSMakeRange(attText.length - 4, 4)];
    }
    
    self.attributedText = attText;
}

- (NSArray *)getSeparatedLinesArray:(CGFloat)width {
    
    NSString *text = [self text];
    UIFont   *font = [self font];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, width, 100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
       
    return (NSArray *)linesArray;
}

@end
