//
//  IWStatus.m
//  ItcastWeibo
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWStatus.h"
#import "NSDate+MJ.h"
#import "MJExtension.h"
#import "IWPhoto.h"

@implementation IWStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [IWPhoto class]};
}

- (NSString *)created_at
{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
#warning 真机调试下, 必须加上这段
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%d分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}

- (void)setSource:(NSString *)source
{
    int loc = [source rangeOfString:@">"].location + 1;
    int length = [source rangeOfString:@"</"].location - loc;
    source = [source substringWithRange:NSMakeRange(loc, length)];
    
    _source = [NSString stringWithFormat:@"来自%@", source];
}
@end
