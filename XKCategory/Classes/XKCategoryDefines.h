//
//  XKCategoryDefines.h
//  XKCategory
//
//  Created by Nicholas on 2020/4/19.
//  Copyright © 2020 kunhum. All rights reserved.
//

#ifndef XKCategoryDefines_h
#define XKCategoryDefines_h

#define  XK_STATUS_BAR_AND_NAVIGATION_BAR_HEIGHT  (XK_IS_IPHONEX_SERIES ? 88.f : 64.f)
//iphonex底部安全区域
#define  XK_IPHONEX_SAFE_BOTTOM_MARGIN (XK_IS_IPHONEX_SERIES ? 34.f : 0.f)

//判断iPhoneX、iPhoneXS
#define XK_IS_IPHONE_X (CGSizeEqualToSize(CGSizeMake(1125, 2436), [UIScreen mainScreen].currentMode.size))
//判断iPHoneXR
#define XK_IS_IPHONE_XR (CGSizeEqualToSize(CGSizeMake(828, 1792), [UIScreen mainScreen].currentMode.size))
//判断iPhoneXS Max
#define XK_IS_IPHONE_XS_MAX (CGSizeEqualToSize(CGSizeMake(1242, 2688), [UIScreen mainScreen].currentMode.size))
//判断iPhone X系列
#define XK_IS_IPHONEX_SERIES (XK_IS_IPHONE_X || XK_IS_IPHONE_XR || XK_IS_IPHONE_XS_MAX)

#define XK_WeakSelf __weak typeof(self) weakSelf = self;
//检查对象
#define XK_CheckObject(object) (object && [object isKindOfClass:[NSNull class]]==NO)
//检查字符串
#define XK_CheckString(string) (string && !isNullObject(string))
#define isNullObject(object) ([object isKindOfClass:[NSNull class]])
#define XK_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#endif /* XKCategoryDefines_h */
