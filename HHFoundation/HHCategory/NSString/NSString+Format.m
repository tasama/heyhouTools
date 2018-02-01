//
//  NSString+Format.m
//  FunnyTicket
//
//  Created by 夏玉林 on 16/12/9.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)

#pragma mark - 时间转换
+ (NSString *)changeNSdateFormate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //设置时区(全中国都是一个时区，只要城市对就行)
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Shenzhen"];
    
    return [dateFormatter stringFromDate:date];
}

// 将NSDate转成时间撮
+ (NSString *)changeTimeSpFormate:(NSDate *)date{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];
    
    return timeSp;
}

//!字符串装换成nsdate
+(NSDate *)dateChangeTypeYMDWithString:(NSString *)string dateFormatter:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:dateFormat];
    
    //设置时区(全中国都是一个时区，只要城市对就行)
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Shenzhen"];
    
    return [dateFormatter dateFromString:string];
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

- (NSString *)getImageWithSize:(HHImageSize)size {
    
    NSRange range = [self rangeOfString:@"?"];
    NSString *musicListCover = @"";
    if (range.length > 0) {
        
        musicListCover = [self substringToIndex:range.location];
    } else {
        
        musicListCover = self;
    }
    
    NSString *appendString = @"";
    switch (size) {
        case imageSizeBig:
            appendString = @"?imageMogr2/thumbnail/660x/interlace/1";
            break;
            
        case imageSizeMid:
            appendString = @"?imageMogr2/thumbnail/300x/interlace/1";
            break;
            
        case imageSizeSmall:
            appendString = @"?imageMogr2/thumbnail/100x/interlace/1";
            break;
            
        default:
            break;
    }
    return [musicListCover stringByAppendingString:appendString];
}

+ (NSString *)stringWithPlayTimes:(NSUInteger)times {
    
    if (times >= 10000) {
        
//        if (times % 10000 > 1000) {
        
            return [NSString stringWithFormat:@"%.1f万", times / 10000.f];
//        }
//        else {
//            
//            return [@(times / 10000).stringValue stringByAppendingString:@"万"];
//        }
    }
    return @(times).stringValue;
}

+ (NSString *)stringWithDuration:(NSUInteger)duration {
    
    if (duration >= 3600) {
        
        return [NSString stringWithFormat:@"%02d:%02d:%02d", duration / 3600, (duration / 60) % 60, duration % 60];
    }
    else {
        
        return [NSString stringWithFormat:@"%02d:%02d", duration / 60, duration % 60];
    }
}

- (NSString *)stringWithDeleteTailCharacter:(char *)characters {
    
    if (self.length == 0) {
        
        return self;
    }
    
    char tailChar = [self characterAtIndex:self.length - 1];
    
    for (int j = 0; j < strlen(characters) - 1; j++) {
        
        if (tailChar == characters[j]) {
            
            return [[self substringToIndex:self.length - 2] stringWithDeleteTailCharacter:characters];
        }
    }
    
    return self;
}


- (NSString *)subsrtingToBytes:(NSUInteger)bytes {

    /*
     *  UTF8 编码规则
     *
     *  1. 单字节的字符，字节的第一位设为0，对于英语文本，UTF-8码只占用一个字节，和ASCII码完全相同；
     *  2. n个字节的字符(n>1)，第一个字节的前n位设为1，第n+1位设为0，后面字节的前两位都设为10，这n个字节的其余空位填充该字符unicode码，高位用0补足。
     *
     *  0xxxxxxx
     *  110xxxxx 10xxxxxx
     *  1110xxxx 10xxxxxx 10xxxxxx
     *  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
     *  111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 
     *  1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
     *  11111110 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
     *
     */
    
    
    NSMutableData *mData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    if (mData.length > bytes) {
        
        mData = [mData subdataWithRange:NSMakeRange(0, bytes)];
    }
    
    Byte lastByte;  //最后一个字节
    
    NSUInteger length = mData.length;

    [mData getBytes:&lastByte range:NSMakeRange(length - 1, 1)];
    
    //  单字节字符
    if (lastByte < 0x80 /*0x 1000 0000*/) {
        
        return [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    }// 多字节字符起始字节，直接丢弃
    else if (lastByte > 0xc0 /*0x 1100 0000*/) {
        
        mData = [mData subdataWithRange:NSMakeRange(0, length - 1)];
        
        return [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    }
    else {
        //  从最后一字节往前查找最后一个字符首字节
        int offset = 1;
        
        do {
        
            offset ++;
            [mData getBytes:&lastByte range:NSMakeRange(length - offset, 1)];

        } while (lastByte <= 0xbf /*0x 1011 1111*/);
        
        //  大小为offset的字符的首字节最大值（第offset位置0）
        Byte tmpByte = (0xff >> (offset + 1)) | (0xff << (8 - offset));
        
        //  截取字符串不完整，丢弃最后一个字符部分内容
        if (lastByte > tmpByte) {
            
            mData = [mData subdataWithRange:NSMakeRange(0, length - offset)];
        }
        
        return [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    }

//    for (NSUInteger i = 0; i < length;) {
//        
//        [mData getBytes:&byte range:NSMakeRange(i, 1)];
//        
//        for (int j = 0; j < 7; j++) {
//            
//            //  如果首字节大于字符字节大小编码，则偏移相应大小
//            if (byte >= sizeCode[j]) {
//                
//                //  偏移
//                int offset = 7 - j;
//                
//                //  如果偏移超出data大小，表示截断字符串不完整，丢弃不完整部分
//                if (i + offset > length) {
//                    
//                    mData = [mData subdataWithRange:NSMakeRange(0, i)];
//                    
//                    return [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
//                }
//                else if (i + offset == length) {
//                    
//                    return [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
//                }
//                else {
//                    
//                    i += offset;
//                    break;
//                }
//            }
//        }
//    }
    
    return nil;
}

@end
