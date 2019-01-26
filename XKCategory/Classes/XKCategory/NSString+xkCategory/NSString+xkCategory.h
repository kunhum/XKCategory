//
//  NSString+XKStringTools.h
//  Minshuku
//
//  Created by Nicholas on 16/9/26.
//  Copyright © 2016年 Nicholas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+RegexCategory.h"
#import <UIKit/UIKit.h>

@interface NSString (xkCategory)

///将汉字转换为拼音
- (NSString *)xk_pinyinOfName;

///汉字转换为拼音后，返回大写的首字母
- (NSString *)xk_uppercasePinYinFirstLetter;

///URL编码
- (NSString *)xk_urlEncodedString;

///URL解码
- (NSString *)xk_urlDecodedString;

///判断是否包含emoji
- (BOOL)xk_isIncludingEmoji;

///判断当前字符是否emoji
- (BOOL)xk_isEmoji;

///删除emoji
- (instancetype)xk_stringByRemovingEmoji;

/// 生成随机字符串
+ (NSString *)xk_getARCString:(NSInteger)place;

///处理html字符串中的图片，达到适配设备的效果
- (NSString *)xk_webImageFitToDeviceSize;

///处理html字符串,适配屏幕
- (NSString *)xk_fitHtmlStringWithWidth:(CGFloat)width;

///去除h5标签
- (NSString *)xk_filterHTMLLabel;

///根据h5获取attributeString
- (NSMutableAttributedString *)xk_getAttributeStringFromH5;

///让WKWebView适配,默认width为屏幕宽减20
- (NSString *)xk_fitHtmlForWKWebViewWithWidth:(CGFloat)width;

///拼音带声调
- (NSString *)xk_stringToMandarinLatin;

///拼音不带声调
- (NSString *)xk_stringToStripDiacritics;

///去除声调
- (void)xk_removeToneWithRange:(CFRange)range;

///复制到粘贴板
- (void)xk_copyToPasteboard;

///将字符串转换为日期
- (NSDate *)xk_convertToDateWithFormatter:(NSString *)formatter;

///正则判断
- (BOOL)xk_matchWithRegex:(NSString *)regex;

///验证字符串是否符合
- (BOOL)xk_validateWithCharacterSetInString:(NSString *)characters;

///处理中文，例如在url中有中文
- (NSString *)xk_encodeChinese;

///判断字符串中是否有中文
- (BOOL)xk_containChinese;

@end
