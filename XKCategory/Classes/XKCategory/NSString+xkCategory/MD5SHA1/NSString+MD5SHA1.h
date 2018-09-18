//
//  NSString+MD5SHA1.h
//  StringEncrption
//
//  Created by Nicholas on 16/3/4.
//  Copyright © 2016年 Nicholas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5SHA1)
/**
 * MD5加密
 */
- (NSString *)MD5;
/**
 * 使用GTMBase64编码，MD5加密
 */
- (NSString *)MD5base64;
/**
 * SHA1加密
 */
- (NSString *)SHA1;
/**
 * 使用GTMBase64编码，SHA1加密
 */
- (NSString *)SHA1base64;
/**
 * 使用GTMBase64编码
 */
- (NSString *)base64;

@end
