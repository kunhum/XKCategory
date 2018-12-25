//
//  UIImage+xkCategory.m
//  BlindDate
//
//  Created by Nicholas on 2017/12/4.
//  Copyright © 2017年 Skingen. All rights reserved.
//

#import "UIImage+xkCategory.h"

@implementation UIImage (xkCategory)

#pragma mark 根据颜色创建图片
+ (UIImage *)xk_imageWithColor:(UIColor *)color frame:(CGRect)colorFrame {
    
    UIGraphicsBeginImageContext(colorFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, colorFrame);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
#pragma mark 截屏
+ (UIImage *)xk_screenShot {
    
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            CGContextTranslateCTM(context,-[window bounds].size.width * [[window layer] anchorPoint].x,-[window bounds].size.height * [[window layer] anchorPoint].y);
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark 根据view生成图片
+ (UIImage *)xk_imageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 压缩图片至指定大小
- (NSData *)xk_compressToKb:(NSUInteger)maxLength {
    
    // Compress by quality
    CGFloat compression = 1;
    NSUInteger maxBytes = maxLength*1000;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxBytes) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxBytes * 0.9) {
            min = compression;
        } else if (data.length > maxBytes) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxBytes) return data;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxBytes && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio  = (CGFloat)maxBytes / data.length;
        CGSize size    = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    //    NSLog(@"%fkb",data.length/1000.0);
    
    return data;
}

#pragma mark 拉伸图片
- (UIImage *)xk_resizableImage {
    
    CGSize imageSize = self.size;
    UIImage *image   = [self resizableImageWithCapInsets:UIEdgeInsetsMake(imageSize.height/2.0, imageSize.width/2.0, imageSize.height/2.0, imageSize.width/2.0) resizingMode:UIImageResizingModeStretch];
    return image;
}

#pragma mark 毛玻璃
- (UIImage *)xk_blearImageWithBlurLevel:(CGFloat)blurLevel {
    CIContext *context   = [CIContext contextWithOptions:nil];
    CIImage *inputImage  = [[CIImage alloc] initWithImage:self];
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setDefaults];
    [blurFilter setValue:inputImage forKey:@"inputImage"];
    //设值模糊的级别
    [blurFilter setValue:[NSNumber numberWithFloat:blurLevel] forKey:@"inputRadius"];
    CIImage *outputImage = [blurFilter valueForKey:@"outputImage"];
    CGRect rect          = inputImage.extent;    // Create Rect
    //设值一下 减到图片的白边
    rect.origin.x     += blurLevel;
    rect.origin.y     += blurLevel;
    rect.size.height  -= blurLevel * 2.0f;
    rect.size.width   -= blurLevel * 2.0f;
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:rect];
    //获取新的图片
    UIImage *newImage  = [UIImage imageWithCGImage:cgImage scale:0.5 orientation:self.imageOrientation];
    //释放图片
    CGImageRelease(cgImage);
    
    return newImage;
}

#pragma mark 裁剪图片
- (UIImage *)xk_cutImageWithSize:(CGSize)cutSize {
    UIGraphicsBeginImageContextWithOptions(cutSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, cutSize.width, cutSize.height)];
    //从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark 加水印
- (UIImage *)xk_waterImageWithImage:(UIImage *)waterImage {
    CGSize imageViewSize = self.size;
    UIGraphicsBeginImageContextWithOptions(imageViewSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, imageViewSize.width, imageViewSize.height)];
    CGFloat scale = 0.2;
    CGFloat waterW = imageViewSize.width * scale;
    CGFloat waterH = imageViewSize.height * scale;
    CGFloat waterX = (imageViewSize.width - waterW) / 2.0;
    CGFloat waterY = (imageViewSize.height - waterH) / 2.0;
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark 无渲染图片
- (UIImage *)xk_OriginalRenderingImage {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  修改图片size
 *
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
- (UIImage *)xk_imageScalingToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark 创建二维码
+ (UIImage *)xk_createQRCodeWithString:(NSString *)codeString size:(CGFloat)size {
    
    //创建二维码滤镜实例
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //滤镜恢复默认数据
    [filter setDefaults];
    
    //数据处理
    NSData *codeData = [codeString dataUsingEncoding:NSUTF8StringEncoding];
    //赋值
    [filter setValue:codeData forKey:@"inputMessage"];
    
    //生成二维码
    CIImage *image = [filter outputImage];
    
    //对二维码进行处理，如不经过处理，二维码会很小
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark 创建带图片二维码
+ (UIImage *)xk_createQRCodeWithString:(NSString *)codeString waterImage:(UIImage *)waterImage size:(CGFloat)size {
    
    UIImage *qrCodeImage = [self xk_createQRCodeWithString:codeString size:size];
    CGSize waterSize = CGSizeMake(size * 0.2, size * 0.2);
    UIImage *centerImage = [waterImage xk_imageScalingToSize:waterSize];
    //加水印
    return [qrCodeImage xk_waterImageWithImage:centerImage];
}

@end
