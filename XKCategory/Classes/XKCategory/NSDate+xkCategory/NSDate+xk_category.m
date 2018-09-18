//
//  NSDate+xk_category.m
//  BBCar
//
//  Created by Nicholas on 2017/2/18.
//  Copyright © 2017年 nicholas. All rights reserved.
//
/*
 一月 January 简写 Jan.
 二月 February 简写 Feb.
 三月 March 简写 Mar.
 四月 April 简写 Apr.
 五月 May 简写 May
 六月 June 简写 Jun.
 七月 July 简写 Jul.
 八月 August 简写 Aug.
 九月September 简写Sep.
 十月 October 简写 Oct.
 十一月November 简写 Nov.
 十二月December 简写 Dec.
 
 星期一： Mon.=Monday
 星期二： Tue.=Tuesday
 星期三： Wed.=Wednesday
 星期四： Thu.=Thursday
 星期五： Fri.=Friday
 星期六： Sat.=Saturday
 星期天： Sun.=Sunday
 */

#import "NSDate+xk_category.h"

@implementation NSDate (xk_category)

#pragma mark -- 通过时间间隔和格式获取日期字符串
+ (NSString *)xk_getDateSince1970ByInterval:(NSTimeInterval)interval withFormat:(NSString *)format {
    if (format == nil) {
        return nil;
    }
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

#pragma mark -- 判断某个时间是否为今年
- (BOOL)xk_isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

#pragma mark -- 判断某个时间是否为昨天
- (BOOL)xk_isYesterday {
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

#pragma mark -- 判断某个时间是否为今天
- (BOOL)xk_isToday {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

#pragma mark -- 获取日期创建时间
+ (NSString *)xk_dateCreatedAt:(NSTimeInterval)interval {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
//    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //    _created_at = @"Tue Sep 30 17:06:25 +0600 2014";
    
    // 创建日期
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:interval];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate xk_isThisYear]) { // 今年
        if ([createDate xk_isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate xk_isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

#pragma mark  将日期转换为字符串
- (NSString *)xk_toStringWithFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:self];
}

//#pragma mark 比较两个日期
//+ (NSComparisonResult)xk_compareDate:(NSDate *)aDate andAnotherDate:(NSDate *)bDate {
//    
//    NSCalendar *curCalendar = [NSCalendar currentCalendar];
//    curCalendar compareDate:aDate toDate:bDate toUnitGranularity:<#(NSCalendarUnit)#>
//}

@end
