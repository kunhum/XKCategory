//
//  UIImage+xkCategory.h
//  BlindDate
//
//  Created by Nicholas on 2017/12/4.
//  Copyright © 2017年 Skingen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (xkCategory)

///根据颜色创建图片
+ (UIImage*)xk_imageWithColor:(UIColor *)color frame:(CGRect)colorFrame;
///截屏
+ (UIImage *)xk_screenShot;
///截取view生成图片
+ (UIImage *)xk_imageFromView:(UIView *)view;

///压缩图片至指定大小
- (NSData *)xk_compressToKb:(NSUInteger)maxLength;
///拉伸图片
- (UIImage *)xk_resizableImage;
///毛玻璃
- (UIImage *)xk_blearImageWithBlurLevel:(CGFloat)blurLevel;
///裁剪图片
- (UIImage *)xk_cutImageWithSize:(CGSize)cutSize;
///加水印
- (UIImage *)xk_waterImageWithImage:(UIImage *)waterImage;
///无渲染图片
- (UIImage *)xk_OriginalRenderingImage;

/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage *)image byScalingToSize:(CGSize)targetSize;


@end
