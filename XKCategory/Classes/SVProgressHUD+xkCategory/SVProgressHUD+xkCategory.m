//
//  SVProgressHUD+xkCategory.m
//  BlindDate
//
//  Created by Nicholas on 2017/12/1.
//  Copyright © 2017年 Skingen. All rights reserved.
//

#import "SVProgressHUD+xkCategory.h"
#import "XKCategoryDefines.h"

@implementation SVProgressHUD (xkCategory)

+ (void)xk_showClearMaskStatus:(NSString *)message {
    
    //    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, XK_SCREEN_HEIGHT / 3.0)];
    if (XK_CheckString(message) == NO) {
        [SVProgressHUD dismiss];
        return;
    }
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self showWithStatus:message];
}
+ (void)xk_showLoadingWithStatus:(NSString *)message {
    if (XK_CheckString(message) == NO) {
        [SVProgressHUD dismiss];
        return;
    }
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self showWithStatus:message];
}
+ (void)xk_showWithStatus:(NSString *)message completed:(void (^)(void))completed {

//    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, XK_SCREEN_HEIGHT / 3.0)];
    if (XK_CheckString(message) == NO) {
        [SVProgressHUD dismiss];
        return;
    }
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self showWithStatus:message];
    [self dismissWithDelay:kAnimationDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completed) completed();
    });
}
+ (void)xk_showErrorWithStatus:(NSString *)message completed:(void (^)(void))completed {

//    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, XK_SCREEN_HEIGHT / 3.0)];
    if (XK_CheckString(message) == NO) {
        [SVProgressHUD dismiss];
        return;
    }
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self showErrorWithStatus:message];
    [self dismissWithDelay:kAnimationDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completed) completed();
    });
}
+ (void)xk_showInfoWithStatus:(NSString *)message completed:(void (^)(void))completed {

//    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, XK_SCREEN_HEIGHT / 3.0)];
    if (XK_CheckString(message) == NO) {
        [SVProgressHUD dismiss];
        return;
    }
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self showInfoWithStatus:message];
    [self dismissWithDelay:kAnimationDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completed) completed();
    });
}
+ (void)xk_showSuccessWithStatus:(NSString *)message completed:(void (^)(void))completed {
    
//    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, XK_SCREEN_HEIGHT / 3.0)];
    if (XK_CheckString(message) == NO) {
        [SVProgressHUD dismiss];
        return;
    }
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self showSuccessWithStatus:message];
    [self dismissWithDelay:kAnimationDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completed) completed();
    });
}

+ (void)xk_showWithClearMask {
    
//    [SVProgressHUD resetOffsetFromCenter];
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self show];
}

+ (void)xk_show {
//    [SVProgressHUD resetOffsetFromCenter];
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self show];
}

+ (void)xk_showMessage:(NSString *)message completed:(void (^)(void))completed {
    
//    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, XK_SCREEN_HEIGHT / 3.0)];
    
    if (XK_CheckString(message) == NO) {
        [SVProgressHUD dismiss];
        return;
    }
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self showImage:nil status:message];
    [self dismissWithDelay:kAnimationDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completed) completed();
    });
}


+ (void)xk_showMessage:(NSString *)message maskType:(SVProgressHUDMaskType)maskType completed:(void (^)(void))completed {
    
    if (XK_CheckString(message) == NO) {
        [SVProgressHUD dismiss];
        return;
    }
    [self setDefaultMaskType:maskType];
    [self showImage:nil status:message];
    [self dismissWithDelay:kAnimationDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completed) completed();
    });
}

@end
