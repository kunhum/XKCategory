//
//  UITextView+xkCategory.h
//  PinShangHome
//
//  Created by Nicholas on 2018/1/25.
//  Copyright © 2018年 com.xiaopao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XKInsertLimiter;

@interface UITextView (xkCategory)

@property (nonatomic, strong) XKInsertLimiter *insertLimit;

///是否不需要自适应高度，默认为NO
@property (nonatomic, assign) BOOL doNotAdjustFont;

@end
