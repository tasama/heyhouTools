//
//  NSString+Format.h
//  FunnyTicket
//
//  Created by 夏玉林 on 16/12/9.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>

typedef enum {
    
    imageSizeBig,
    imageSizeMid,
    imageSizeSmall
    
} HHImageSize;

@interface NSString (Format)

#pragma mark - 时间转换
// 将NSDate转成yyyy-MM-dd HH:mm
+ (NSString *)changeNSdateFormate:(NSDate *)date;

// 将NSDate转成时间撮
+ (NSString *)changeTimeSpFormate:(NSDate *)date;

//!字符串装换成nsdate
+(NSDate *)dateChangeTypeYMDWithString:(NSString *)string dateFormatter:(NSString *)dateFormat;

- (NSString *)getImageWithSize:(HHImageSize)size;

/**
 检测是否包含表情符

 @param string 输入详情

 @return 返回判断值
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;


/**
 获取格式化的播放次数字符串

 @param times 次数
 @return 播放次数字符串
 */
+ (NSString *)stringWithPlayTimes:(NSUInteger)times;

/**
 *  将时长转换成音视频时长字符串
 *
 *  @param duration 时长
 *  @return         时长字符串
 */
+ (NSString *)stringWithDuration:(NSUInteger)duration;


/// 删除字符串尾部字符
- (NSString *)stringWithDeleteTailCharacter:(char *)characters;

/// 根据最大字节数，获取字符串
- (NSString *)subsrtingToBytes:(NSUInteger)bytes;

@end
