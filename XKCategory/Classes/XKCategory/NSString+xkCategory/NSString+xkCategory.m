//
//  NSString+XKStringTools.m
//  Minshuku
//
//  Created by Nicholas on 16/9/26.
//  Copyright © 2016年 Nicholas. All rights reserved.
//

#import "NSString+xkCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

//检查对象
#define XK_CheckObject(object) (object && [object isKindOfClass:[NSNull class]]==NO)
//检查字符串
#define XK_CheckString(string) (string && !isNullObject(string))
#define isNullObject(object) ([object isKindOfClass:[NSNull class]])
#define XK_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static NSCharacterSet *VariationSelectors = nil;

@implementation NSString (xkCategory)

+ (void)load {
    
    //交换字符串拼接的方法
    Method appendMethod = class_getInstanceMethod([self class], @selector(stringByAppendingString:));
    Method xk_appendMethod = class_getInstanceMethod([self class], @selector(xk_stringByAppendString:));
    method_exchangeImplementations(appendMethod, xk_appendMethod);
    
    Method subMethod = class_getInstanceMethod(self, @selector(substringToIndex:));
    Method xk_subMethod = class_getInstanceMethod(self, @selector(xk_substringToIndex:));
    method_exchangeImplementations(subMethod, xk_subMethod);
    
    VariationSelectors = [NSCharacterSet characterSetWithRange:NSMakeRange(0xFE00, 16)];
}

#pragma mark -- 字符串拼接
- (NSString *)xk_stringByAppendString:(NSString *)appendString {
    
    if (XK_CheckString(appendString) == NO) appendString = @"";
    if (XK_CheckString(self) == NO) {
        return [@"" xk_stringByAppendString:appendString];
    };
    
    return [self xk_stringByAppendString:appendString];
}

#pragma mark 剪切字符串
- (NSString *)xk_substringToIndex:(NSUInteger)to {
    
    if (to > self.length) {
        to = self.length;
    }
    return [self xk_substringToIndex:to];
}

#pragma mark - 汉字转换为拼音

- (NSString *)xk_pinyinOfName {
    NSMutableString *name = [[NSMutableString alloc] initWithString:self];
    
    CFRange range = CFRangeMake(0, name.length);
    
    // 汉字转换为拼音,并去除音调
    if (!CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformMandarinLatin, NO) ||
        !CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    NSString *usefulName = name;
    usefulName = [usefulName stringByReplacingOccurrencesOfString:@" " withString:@""];
    return usefulName;
}

#pragma mark - 汉字转换为拼音后，返回大写的首字母

- (NSString *)xk_uppercasePinYinFirstLetter {
    
//    NSLog(@"--> %@",self);
    if (XK_CheckString(self) == NO || self.length < 1) {
        return @"#";
    }
    
    NSMutableString * first = [[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]];
    
    CFRange range = CFRangeMake(0, 1);
    
    // 汉字转换为拼音,并去除音调
    if (!CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
        !CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    NSString * result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    
    return result.uppercaseString;
}

- (BOOL)xk_isEmoji {
    if ([self rangeOfCharacterFromSet: VariationSelectors].location != NSNotFound) {
        return YES;
    }
    
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F9FF)
    if (0xD800 <= high && high <= 0xDBFF) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
        
        return (0x1D000 <= codepoint && codepoint <= 0x1F9FF);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27BF);
    }
}

- (BOOL)xk_isIncludingEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring xk_isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    return result;
}

- (instancetype)xk_stringByRemovingEmoji {
    
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring xk_isEmoji])? @"": substring];
                          }];
    
    return buffer;
}

- (instancetype)removedEmojiString {
    return [self xk_stringByRemovingEmoji];
}

#pragma mark - 获取随机字符串
+ (NSString *)xk_getARCString:(NSInteger)place {
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < place; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

#pragma mark -- 处理html中的图片达到适配设备的效果
- (NSString *)xk_webImageFitToDeviceSize {
    
    NSString *string = self;
    
    NSMutableString *strContent = [NSMutableString stringWithString:string];
    
    [strContent appendString:@"<html>"];
    [strContent appendString:@"<head>"];
    [strContent appendString:@"<meta charset=\"utf-8\">"];
    [strContent appendString:@"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width-16,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />"];
    [strContent appendString:@"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />"];
    [strContent appendString:@"<style>img{width:10%;}</style>"];
    [strContent appendString:@"<style>table{width:100%;}</style>"];
    [strContent appendString:@"<style>img{height:auto;}</style>"];
    [strContent appendString:@"<title>webview</title>"];
    
    return strContent;
}

#pragma mark - 适配html字符串
- (NSString *)xk_fitHtmlStringWithWidth:(CGFloat)width {
    if (self == nil) return self;
    NSString *str = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx;height:auto !important;}</style></head>",width];
    return [str stringByAppendingString:self];
}

#pragma mark 去除h5标签
- (NSString *)xk_filterHTMLLabel {
    NSString *filterStr = self;
    NSScanner *scanner  = [NSScanner scannerWithString:filterStr];
    NSString *text      = nil;
    while([scanner isAtEnd] == NO) {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
//        NSLog(@"text:%@",text);
//        NSLog(@"needReplace:%@",[NSString stringWithFormat:@"%@>",text]);
//        NSLog(@"------------");
        filterStr = [filterStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return filterStr;
}

#pragma mark 根据h5获取attributeString
- (NSMutableAttributedString *)xk_getAttributeStringFromH5 {
    NSString *str = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx;height:auto !important;}</style></head>",XK_SCREEN_WIDTH-20];
    NSString *tempStr = [str stringByAppendingString:self];
    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithData:[tempStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return contentText;
}

#pragma mark h5适配WKWebview
- (NSString *)xk_fitHtmlForWKWebViewWithWidth:(CGFloat)width {
    
    NSString *header = [NSString stringWithFormat:@"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header><head><style>img{max-width:%fpx !important;}</style></head>",width == 0.0 ? (XK_SCREEN_WIDTH - 16.0) : width];
    return [header stringByAppendingString:self];
}

#pragma mark 带声调的拼音
- (NSString *)xk_stringToMandarinLatin {
    NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
    return ms;
}
#pragma mark 不带声调的拼音
- (NSString *)xk_stringToStripDiacritics {
    NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO);
    return ms;
}
#pragma mark 去除声调
- (void)xk_removeToneWithRange:(CFRange)range {
    //去除音调
    if (!CFStringTransform((__bridge CFMutableStringRef) self, &range, kCFStringTransformMandarinLatin, NO) ||
        !CFStringTransform((__bridge CFMutableStringRef) self, &range, kCFStringTransformStripDiacritics, NO)) {
    }
}
#pragma mark URLEncode
- (NSString *)xk_urlEncodedString {
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'\"();:@&=+$,/?%#[]% "].invertedSet];
}

#pragma mark URLDecode
- (NSString *)xk_urlDecodedString {
    
    return [self stringByRemovingPercentEncoding];
}

#pragma mark 复制到粘贴板
- (void)xk_copyToPasteboard {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self;
}

#pragma mark 将字符串转换为日期
- (NSDate *)xk_convertToDateWithFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:self];
}

#pragma mark 正则判断
- (BOOL)xk_matchWithRegex:(NSString *)regex {
    //SELF MATCHES 一定是大写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

#pragma mark 验证字符串是否符合
- (BOOL)xk_validateWithCharacterSetInString:(NSString *)characters {
    BOOL result = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:characters];
    int i =0;
    while (i < self.length) {
        NSString *string = [self substringWithRange:NSMakeRange(i,1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length ==0) {
            result = NO;
            break;
        }
        i++;
    }
    return result;
}

#pragma mark 处理字符串中的中文
- (NSString *)xk_encodeChinese {
    
    BOOL hasChinese = [self xk_containChinese];
    NSString *afterHandleStr = self;
    if (hasChinese) {
        afterHandleStr = [afterHandleStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    }
    return afterHandleStr;
}

#pragma mark 是否包含中文
- (BOOL)xk_containChinese {
    
    for(int i = 0; i < [self length]; i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

@end
