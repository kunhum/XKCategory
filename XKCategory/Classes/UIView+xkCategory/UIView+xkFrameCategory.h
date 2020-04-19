//
//  UIView+xkFrameCategory.h
//  TestDemo
//
//  Created by Nicholas on 2017/11/2.
//  Copyright © 2017年 nicholas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (xkFrameCategory)

@property (nonatomic, assign) CGFloat xk_x;
@property (nonatomic, assign) CGFloat xk_y;
@property (nonatomic, assign) CGFloat xk_centerX;
@property (nonatomic, assign) CGFloat xk_centerY;
@property (nonatomic, assign) CGFloat xk_width;
@property (nonatomic, assign) CGFloat xk_height;
@property (nonatomic, assign) CGSize  xk_size;
@property (nonatomic, assign) CGPoint xk_origin;

@end
