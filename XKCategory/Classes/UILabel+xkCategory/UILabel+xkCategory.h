//
//  UILabel+xkCategory.h
//  FateTeacher-IOS
//
//  Created by Nicholas on 2017/12/26.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (xkCategory)

///是否不需要自适应高度，默认为NO
@property (nonatomic, assign) BOOL doNotAdjustFont;
///将后面的显示...且在最后添加suffixText
- (void)xk_setLineBreakByTruncatingLastLineWithWidth:(CGFloat)width suffixText:(NSString *)suffixText suffixTextColor:(UIColor *)suffixTextColor lineSpacing:(CGFloat)lineSpacing;

@end
