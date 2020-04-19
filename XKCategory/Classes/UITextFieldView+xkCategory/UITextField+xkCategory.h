//
//  UITextField+xkCategory.h
//  PinShangHome
//
//  Created by Nicholas on 2017/11/24.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XKInsertLimiter;

@interface UITextField (xkCategory)

/**
 * 在textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string代理方法中使用
 * 不能输入.0-9以外的字符。
 * 设置输入框输入的内容格式
 * 只能有一个小数点
 * 小数点后最多能输入两位
 * 如果第一位是.则前面加上0.
 * 如果第一位是0则后面必须输入点，否则不能输入。

 @param string replaceString
 @param range range
 @return yes or no
 */
- (BOOL)xk_justCanInsertNumberAndDecimalPointInChangeDelegateWithChangeString:(NSString *)string range:(NSRange)range;

///是否不需要自适应高度，默认为NO
@property (nonatomic, assign) BOOL doNotAdjustFont;

@property (nonatomic, strong) XKInsertLimiter *insertLimit;

@end
