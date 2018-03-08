//
//  NSDate+BRAdd.h
//  BRPickerViewDemo
//
//  Created by 任波 on 2017/8/11.
//  Copyright © 2017年 renb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BRAdd)
/** 获取当前的时间 */
+ (NSString *)currentDateString;

/** 获取两个日期之间的天数 **/
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
@end
