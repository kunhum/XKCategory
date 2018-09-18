//
//  NSDate+xk_category.h
//  BBCar
//
//  Created by Nicholas on 2017/2/18.
//  Copyright © 2017年 nicholas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (xk_category)

/**
 1.今年
 1> 今天
 * 1分内： 刚刚
 * 1分~59分内：xx分钟前
 * 大于60分钟：xx小时前
 
 2> 昨天
 * 昨天 xx:xx
 
 3> 其他
 * xx-xx xx:xx
 
 2.非今年
 1> xxxx-xx-xx xx:xx
 */
+ (NSString *)xk_dateCreatedAt:(NSTimeInterval)interval;

/**
 通过时间间隔和格式获取日期字符串
 
 @param interval 时间间隔
 @param format 格式
 @return 日期字符串
 */
+ (NSString *)xk_getDateSince1970ByInterval:(NSTimeInterval)interval withFormat:(NSString *)format;

///**
// 比较两个日期
//
// @param aDate 第一个
// @param bDate 第二个
// @return 比较结果
// */
//+ (NSComparisonResult)xk_compareDate:(NSDate *)aDate andAnotherDate:(NSDate *)bDate;
/**
 判断是否为今年

 @return yes or no
 */
- (BOOL)xk_isThisYear;
/**
 判断是否为昨天

 @return yes or no
 */
- (BOOL)xk_isYesterday;
/**
 判断是否为今天

 @return yes or no
 */
- (BOOL)xk_isToday;

/**
 将日期转换为字符串

 @param dateFormat 格式
 @return 字符串
 */
- (NSString *)xk_toStringWithFormat:(NSString *)dateFormat;


@end
