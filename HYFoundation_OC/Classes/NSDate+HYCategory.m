//
//  NSDate+HYCategory.m
//  日期和时间
//
//  Created by ocean on 16/5/24.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import "NSDate+HYCategory.h"

@implementation NSDate (HYCategory)

- (BOOL)hy_isMinute { //目标日期和当前日期的 年，月，日，时，分相同
    return [NSDate hy_isMinuteDate:[NSDate date] andDate:self];
}

+ (BOOL)hy_isMinuteDate:(NSDate *)date andDate:(NSDate *)anotherDate {
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *current = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *destination = [[NSCalendar currentCalendar] components:unit fromDate:anotherDate];
    return  (current.year == destination.year)&&
    (current.month == destination.month)&&
    (current.day == destination.day)&&
    (current.hour == destination.hour)&&
    (current.minute == destination.minute);
}

- (BOOL)hy_isHour { //目标日期和当前日期的 年，月，日，时相同
    return [NSDate hy_isHourDate:[NSDate date] andDate:self];
}

+ (BOOL)hy_isHourDate:(NSDate *)date andDate:(NSDate *)anotherDate {
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents *current = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *destination = [[NSCalendar currentCalendar] components:unit fromDate:anotherDate];
    return  (current.year == destination.year)&&
            (current.month == destination.month)&&
            (current.day == destination.day)&&
            (current.hour == destination.hour);
}

- (BOOL)hy_isToday { //目标日期和当前日期的年，月，日相同，则两个日期在同一天
    return [NSDate hy_isTodayDate:[NSDate date] andDate:self];
}

+ (BOOL)hy_isTodayDate:(NSDate *)date andDate:(NSDate *)anotherDate {
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *current = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *destination = [[NSCalendar currentCalendar] components:unit fromDate:anotherDate];
    return  (current.year == destination.year) &&
            (current.month == destination.month) &&
            (current.day == destination.day);
}

- (BOOL)hy_isYesterday { //判断两个日期的年，月，日的情况，昨天日期和目标进行比较
    return [NSDate hy_isYesterdayDate:[NSDate date] andDate:self];
}

+ (BOOL)hy_isYesterdayDate:(NSDate *)date andDate:(NSDate *)anotherDate {
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDate *yesterdayDate = [NSDate dateWithTimeInterval:-86400 sinceDate:date];
    NSDateComponents *yesterday = [[NSCalendar currentCalendar] components:unit fromDate:yesterdayDate];
    NSDateComponents *destination = [[NSCalendar currentCalendar] components:unit fromDate:anotherDate];
    return  (yesterday.year == destination.year)&&
            (yesterday.month == destination.month)&&
            (yesterday.day == destination.day);
}

- (BOOL)hy_isTomorrow {
    return [NSDate hy_isTomorrowDate:[NSDate date] andDate:self];
}

+ (BOOL)hy_isTomorrowDate:(NSDate *)date andDate:(NSDate *)anotherDate {
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDate *tomorrowDate = [NSDate dateWithTimeInterval:86400 sinceDate:date];
    NSDateComponents *tomorrow = [[NSCalendar currentCalendar] components:unit fromDate:tomorrowDate];
    NSDateComponents *destination = [[NSCalendar currentCalendar] components:unit fromDate:anotherDate];
    return  (tomorrow.year == destination.year)&&
            (tomorrow.month == destination.month)&&
            (tomorrow.day == destination.day);
}


- (BOOL)hy_isThisWeek { //目标日期和当前日期的 年，月，周相同
    return [NSDate hy_isThisWeekDate:[NSDate date] andDate:self];
}

+ (BOOL)hy_isThisWeekDate:(NSDate *)date andDate:(NSDate *)anotherDate {
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth;
    NSDateComponents *current = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *destination = [[NSCalendar currentCalendar] components:unit fromDate:anotherDate];
    return  (current.year == destination.year)&&
            (current.month == destination.month)&&
            (current.weekOfMonth == destination.weekOfMonth);
}

- (BOOL)hy_isThisMonth {
    return [NSDate hy_isThisMonthDate:[NSDate date] andDate:self];
}

+ (BOOL)hy_isThisMonthDate:(NSDate *)date andDate:(NSDate *)anotherDate {
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *current = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *destination = [[NSCalendar currentCalendar] components:unit fromDate:anotherDate];
    return  (current.year == destination.year)&&
            (current.month == destination.month);
}

- (BOOL)hy_isThisYear { //目标日期和当前日期的 年 相同
    return [NSDate hy_isThisYearDate:[NSDate date] andDate:self];
}

+ (BOOL)hy_isThisYearDate:(NSDate *)date andDate:(NSDate *)anotherDate {
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *current = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *destination = [[NSCalendar currentCalendar] components:unit fromDate:anotherDate];
    return  (current.year == destination.year);
}

- (BOOL)hy_isLeapYear {
    NSUInteger year = self.hy_year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
    /*
     讨论：
     1、世纪年能被400整除的是闰年
     2、普通年能被4整除且不能被100整除的为闰年.
     */
}

- (BOOL)hy_isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] isLeapMonth];
}

#pragma mark - 获取日期单元
- (NSInteger)hy_era {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitEra fromDate:self] era];
}

- (NSInteger)hy_year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)hy_month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)hy_day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hy_hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)hy_minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)hy_second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)hy_weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)hy_realWeekday {
    NSInteger temp = self.hy_weekday;
    return temp == 1 ? 7 : --temp;
}

- (NSString *)hy_realWeekdayString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    if (self.hy_realWeekday == 7) return @"星期日";
    return [NSString stringWithFormat:@"星期%@", [formatter stringFromNumber:@(self.hy_realWeekday)]];
}

- (NSInteger)hy_weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)hy_weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)hy_weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)hy_quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}


#pragma mark - 日期和字符串转化
- (NSString *)hy_stringWithDefaultDateFormatter {
    return [self hy_stringWithDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)hy_stringWithDateFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter stringFromDate:self];
}

+ (NSDate *)hy_dateWithString:(NSString *)dateString formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter dateFromString:dateString];
}


+ (NSString *)hy_dateStringWithDatetime:(long long)datetime formatter:(NSString *)formatter {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:datetime / 1000];
    return [date hy_stringWithDateFormatter:formatter];
}


+ (NSString *)hy_dateStringWithDatetime:(long long)datetime {
    return [NSDate hy_dateStringWithDatetime:datetime formatter:@"yyyy-MM-dd HH:mm:ss"];
}


+ (NSString *)hy_dateStringWithDatetimeNOHourAndMinute:(long long)datetime {
    return [NSDate hy_dateStringWithDatetime:datetime formatter:@"yyyy-MM-dd"];
}

@end
