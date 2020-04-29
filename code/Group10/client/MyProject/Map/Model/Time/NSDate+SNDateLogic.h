//
//  NSDate+SNDateLogic.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SNDateLogic)

- (NSInteger)yearValue;
- (NSInteger)monthValue;
- (NSInteger)dayValue;
- (NSInteger)weekdayValue;

- (NSDate *)beforeDays:(NSInteger)days;
- (NSDate *)afterDays:(NSInteger)days;

- (NSDate *)firstDayOfCurrentMonth;
- (NSDate *)lastDayOfCurrentMonth;
- (NSUInteger)numberOfDaysInCurrentMonth;

+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (NSInteger)hourValue;
- (NSInteger)minuteValue;
- (NSInteger)secondValue;

@end
