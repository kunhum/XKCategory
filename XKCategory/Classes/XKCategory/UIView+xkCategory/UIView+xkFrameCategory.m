//
//  UIView+xkFrameCategory.m
//  TestDemo
//
//  Created by Nicholas on 2017/11/2.
//  Copyright © 2017年 nicholas. All rights reserved.
//

#import "UIView+xkFrameCategory.h"

@implementation UIView (xkFrameCategory)

- (void)setXk_x:(CGFloat)xk_x {
    CGRect frame = self.frame;
    frame.origin.x = xk_x;
    self.frame = frame;
}
- (CGFloat)xk_x {
    return self.frame.origin.x;
}

- (void)setXk_y:(CGFloat)xk_y {
    CGRect frame = self.frame;
    frame.origin.y = xk_y;
    self.frame = frame;
}
- (CGFloat)xk_y {
    return self.frame.origin.y;
}

- (void)setXk_centerX:(CGFloat)xk_centerX {
    CGPoint center = self.center;
    center.x = xk_centerX;
    self.center = center;
}
- (CGFloat)xk_centerX {
    return self.center.x;
}

- (void)setXk_centerY:(CGFloat)xk_centerY {
    CGPoint center = self.center;
    center.y = xk_centerY;
    self.center = center;
}
- (CGFloat)xk_centerY {
    return self.center.y;
}

- (void)setXk_width:(CGFloat)xk_width {
    CGRect frame = self.frame;
    frame.size.width = xk_width;
    self.frame = frame;
}
- (CGFloat)xk_width {
    return self.frame.size.width;
}

- (void)setXk_height:(CGFloat)xk_height {
    CGRect frame = self.frame;
    frame.size.height = xk_height;
    self.frame = frame;
}
- (CGFloat)xk_height {
    return self.frame.size.height;
}

- (void)setXk_size:(CGSize)xk_size {
    CGRect frame = self.frame;
    frame.size = xk_size;
    self.frame = frame;
}
- (CGSize)xk_size {
    return self.frame.size;
}

- (void)setXk_origin:(CGPoint)xk_origin {
    CGRect frame = self.frame;
    frame.origin = xk_origin;
    self.frame = frame;
}
- (CGPoint)xk_origin {
    return self.frame.origin;
}

@end
