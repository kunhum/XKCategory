#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "XKBaseControllerConfig.h"
#import "XKBaseNavigationController.h"
#import "XKBaseTabBarController.h"
#import "XKBaseViewController.h"

FOUNDATION_EXPORT double XKBaseControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char XKBaseControllerVersionString[];

